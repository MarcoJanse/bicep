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

@description('')
param parKeyVaultName string = 'kv-${parApplicationName}-${parEnvironment}'

@description('The region abbreviation: neu for North Europe, weu for West Europe, wus for West US')
@allowed([
  'neu'
  'weu'
  'wus'
])
param parRegion string

@description('Provide the content for deployment, like "pltf" for platform, lzxx for landingzone country or "app" for application')
@allowed([
  'pltf'
  'lznl'
  'app'
])
param parPlatformName string

@description('The name of the Virtual Network (vNet) to reference')
param parVnetName string

@description('Please provide a valid prefix for the subnet within the vNet range, like 10.20.30.0/24')
param parVnetSubnetAddressPrefix string

@description('Provide one of more NSG security rules')
param parNsgRules array = [
  {
    name: 'AllowMgmtICMP'
    priority: '200'
    access: 'Allow'
    direction: 'Inbound'
    protocol: 'ICMP'
    sourceAddressPrefix: '172.20.1.0/24'
    sourcePortRange: '*'
    destinationAddressPrefix: '*'
    destinationPortRange: '*'
  }
  {
    name: 'AllowBastionSsh'
    priority: '250'
    access: 'Allow'
    direction: 'Inbound'
    protocol: 'TCP'
    sourceAddressPrefix: '172.20.0.0/24'
    sourcePortRange: '*'
    destinationAddressPrefix: '*'
    destinationPortRange: '22'
  }
  {
    name: 'AllowBastionRdp'
    priority: '260'
    access: 'Allow'
    direction: 'Inbound'
    protocol: 'TCP'
    sourceAddressPrefix: '172.20.0.0/24'
    sourcePortRange: '*'
    destinationAddressPrefix: '*'
    destinationPortRange: '3389'
  }
  {
    name: 'AllowIntraSubnetTraffic'
    priority: '2048'
    access: 'Allow'
    direction: 'Inbound'
    protocol: '*'
    sourceAddressPrefix: '172.20.1.0/24'
    sourcePortRange: '*'
    destinationAddressPrefix: '172.20.1.0/24'
    destinationPortRange: '*'
  }
  {
    name: 'DenyAllInbound'
    priority: '4096'
    access: 'Deny'
    direction: 'Inbound'
    protocol: '*'
    sourceAddressPrefix: '*'
    sourcePortRange: '*'
    destinationAddressPrefix: '*'
    destinationPortRange: '*'
  }
]

@description('Sets the public network access of the storage account to either Enabled or Disabled')
@allowed([
  'Disabled'
  'Enabled'
])
param parStoragePublicAccess string 

@description('The storage account name using defined naming convention and length')
@minLength(3)
@maxLength(24)
param parStorageAccountName string = 'stste${parApplicationName}${parEnvironment}${parRegion}${padLeft(1, 3, '0')}'

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **resources**

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: parVnetName
}

// **modules**

module KeyVault '../../../../modules/keyVault/keyVault.bicep' = {
  name: '${deployment().name}-keyVaultdeploy'
  params: {
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parKeyVaultName: '${parKeyVaultName}-${padLeft(1, 3, '0')}'
    parLocation: parLocation
    parTags: parTags
  }
}

module networkSecurityGroup '../../../../modules/networkSecurityGroup/networkSecurityGroup.bicep' = {
  name: '${deployment().name}-nsgDeploy'
  params: {
    parNsgName: 'nsg-snet-${parPlatformName}-${parApplicationName}-${parEnvironment}'
    parLocation: parLocation
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parPlatformName: parPlatformName
    parTags: parTags
  }
}

module networkSecurityGroupRule '../../../../modules/networkSecurityGroupRule/networkSecurityGroupRule.bicep' = {
  name: '${deployment().name}-nsgRule'
  params: {
    parNsgName: networkSecurityGroup.name
    parNsgRules: parNsgRules
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

module storageAccount '../../../../modules/storageAccount/storageAccount.bicep' = {
  name: '${deployment().name}-stDeploy'
  params: {
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parLocation: parLocation
    parRegion: parRegion
    parStorageAccountName: parStorageAccountName
    parStoragePublicAccess: parStoragePublicAccess
    parTags: parTags
  }
}
