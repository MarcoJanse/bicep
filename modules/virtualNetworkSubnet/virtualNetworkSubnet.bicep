// **parameters**

@description('Provide the application name that will be used to generate the keyVault name')
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

@description('The platform name for generating a name suitable for the naming convention')
@allowed([
  'app'
  'pltf'
  'lzne'
  'lzde'
])
param parPlatformName string

@description('The name of the Virtual Network (vNet) to reference')
param parVnetName string

@description('This parameter is a wrapper for creating the keyVaultName, but can be overwritten if needed')
param parVnetSubnetName string = 'snet-${parPlatformName}-${parApplicationName}-${parEnvironment}'

@description('Please provide a valid prefix for the subnet within the vNet range, like 10.20.30.0/24')
param parVnetSubnetAddressPrefix string

@description('This parameter can be used to reference an existing Network Security group by its output Id')
param parNsgId string

// **resources**

resource vNet 'Microsoft.Network/virtualNetworks@2022-09-01' existing = {
  name: parVnetName
}

resource vNetSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-09-01' = {
  name: parVnetSubnetName
  parent: vNet
  properties: {
    addressPrefix: parVnetSubnetAddressPrefix
    networkSecurityGroup: {
      id: parNsgId
    }
  }
}

// **outputs**

output outVnetSubnetId string = vNetSubnet.id
