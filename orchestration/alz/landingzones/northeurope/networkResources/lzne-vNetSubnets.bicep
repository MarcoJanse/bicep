// **parameters**

@description('Provide the application name that will be used to generate the subnet name')
param parApplicationName string

@description('Provide the environment abbreviation this resource belongs to, like dev or prd')
@allowed([
  'dev'
  'tst'
  'acc'
  'prd'
  'shd'
])
param parEnvironment string

@description('Provide the Azure region this resource will be deployed to. By default it uses the resource group location')
param parLocation string = resourceGroup().location

@description('The platform name for generating a name suitable for the naming convention')
@allowed([
  'app'
  'pltf'
  'lzne'
  'lzde'
])
param parPlatformName string

@description('This parameter is a wrapper for creating the keyVaultName, but can be overwritten if needed')
param parNsgName string = 'nsg-snet-${parPlatformName}-${parApplicationName}-${parEnvironment}'

@description('The name of the Virtual Network (vNet) to reference')
param parVnetName string

@description('This parameter is a wrapper for creating the keyVaultName, but can be overwritten if needed')
param parVnetSubnetName string = 'snet-${parPlatformName}-${parApplicationName}-${parEnvironment}'

@description('Please provide a valid prefix for the subnet within the vNet range, like 10.20.30.0/24')
param parVnetSubnetAddressPrefix string

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **variables**

var varDefaultSecurityRulesWorkloadSubnets = [
  {
    name: 'AllowMgmtICMP'
    properties: {
      priority: 100
      access: 'Allow'
      direction: 'Inbound'
      protocol: 'ICMP'
      sourceAddressPrefix: '172.20.1.0/24'
      destinationAddressPrefix: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
    }
  }
  {
    name: 'AllowBastionRdp'
    properties: {
      priority: 250
      access: 'Allow'
      direction: 'Inbound'
      protocol: 'Tcp'
      sourceAddressPrefix: '172.20.0.0/24'
      destinationAddressPrefix: '*'
      sourcePortRange: '*'
      destinationPortRange: '3389'
    }
  }
  {
    name: 'AllowBastionSsh'
    properties: {
      priority: 260
      access: 'Allow'
      direction: 'Inbound'
      protocol: 'Tcp'
      sourceAddressPrefix: '172.20.0.0/24'
      destinationAddressPrefix: '*'
      sourcePortRange: '*'
      destinationPortRange: '22'
    }
  }
  {
    name: 'DenyAllInbound'
    properties: {
      priority: 4096
      access: 'Deny'
      direction: 'Inbound'
      protocol: '*'
      sourceAddressPrefix: '*'
      destinationAddressPrefix: '*'
      sourcePortRange: '*'
      destinationPortRange: '*'
    }
  }
]

// **resources**

resource vNet 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: parVnetName
}

// **modules**

module networkSecurityGroup '../../../../../modules/networkSecurityGroup/networkSecurityGroup.bicep' = {
  name: '${deployment().name}-nsgDeploy-${parEnvironment}'
  params: {
    parApplicationName: parApplicationName
    parDefaulSecurityRules: varDefaultSecurityRulesWorkloadSubnets
    parEnvironment: parEnvironment
    parLocation: parLocation
    parNsgName: parNsgName
    parPlatformName: parPlatformName
    parTags: parTags
  }
}

module virtualNetworkSubnet '../../../../../modules/virtualNetworkSubnet/virtualNetWorkSubnet.bicep' = {
  name: '${deployment().name}-snetDeploy-${parEnvironment}'
  params: {
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parNsgId: networkSecurityGroup.outputs.outputNetworkSecurityGroupId
    parPlatformName: parPlatformName
    parVnetName: vNet.name
    parVnetSubnetAddressPrefix: parVnetSubnetAddressPrefix
    parVnetSubnetName: parVnetSubnetName
  }
}
