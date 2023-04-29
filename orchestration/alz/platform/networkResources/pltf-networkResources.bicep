// **parameters**

@description('Provide the environment abbreviation this resource belongs to, like dev or prd')
@allowed([
  'dev'
  'tst'
  'acc'
  'prd'
  'shd'
])
param parEnvironment string

@description('Provide the Azure region this resource will be deployed to.')
param parLocation string

@description('Provide the application name that will be used to generate the keyVault name')
@minLength(3)
@maxLength(4)
param parApplicationName string

@description('The region abbreviation: neu for North Europe, weu for West Europe, wus for West US')
@allowed([
  'neu'
  'weu'
  'wus'
])
param parRegion string

@description('Provide the content for deployment, like "pltf" for platform, lzxx for landingzone country or "app" for application')
@allowed([
  'app'
  'pltf'
  'lzne'
  'lzde'
])
param parPlatformName string

@description('The name of the Virtual Network (vNet) to reference')
param parVnetName string

@description('Please provide a valid prefix for the subnet within the vNet range, like 10.20.30.0/24')
param parVnetSubnetAddressPrefix string

param parNsgName string = 'nsg-snet-${parPlatformName}-${parApplicationName}-${parEnvironment}'

var varNsgRules = [
  {
    name: 'AllowBastionSsh'
    properties: {
      priority: '250'
      access: 'Allow'
      direction: 'Inbound'
      protocol: 'TCP'
      sourceAddressPrefix: '172.20.0.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '22'
    }
  }
  {
    name: 'AllowBastionRdp'
    properties: {
      priority: '260'
      access: 'Allow'
      direction: 'Inbound'
      protocol: 'TCP'
      sourceAddressPrefix: '172.20.0.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '3389'
    }
  }
  {
    name: 'AllowIntraSubnetTraffic'
    properties: {
      priority: '2048'
      access: 'Allow'
      direction: 'Inbound'
      protocol: '*'
      sourceAddressPrefix: '172.20.1.0/24'
      sourcePortRange: '*'
      destinationAddressPrefix: '172.20.1.0/24'
      destinationPortRange: '*'
    }
  }
  {
    name: 'DenyAllInbound'
    properties: {
      priority: '4096'
      access: 'Deny'
      direction: 'Inbound'
      protocol: '*'
      sourceAddressPrefix: '*'
      sourcePortRange: '*'
      destinationAddressPrefix: '*'
      destinationPortRange: '*'
    }
  }
]

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **resources**

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: parVnetName
}

// **modules**

module networkSecurityGroup '../../../../modules/networkSecurityGroup/networkSecurityGroup.bicep' = {
  name: '${deployment().name}-nsgDeploy'
  params: {
    parNsgName: parNsgName
    parLocation: parLocation
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parPlatformName: parPlatformName
    parDefaulSecurityRules: varNsgRules
    parTags: parTags
  }
}

module virtualNetworkSubnet '../../../../modules/virtualNetworkSubnet/virtualNetworkSubnet.bicep' = {
  name: '${deployment().name}-snetDeploy'
  params: {
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parNsgId: networkSecurityGroup.outputs.outputNetworkSecurityGroupId
    parPlatformName: parPlatformName
    parVnetName: virtualNetwork.name
    parVnetSubnetAddressPrefix: parVnetSubnetAddressPrefix
  }
}

