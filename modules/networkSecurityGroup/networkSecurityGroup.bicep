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

@description('Provide the Azure region this resource will be deployed to. By default it uses the resource group location')
param parLocation string = resourceGroup().location

@description('Provide the content for deployment, like "pltf" for platform, lzxx for landingzone country or "app" for application')
@allowed([
  'app'
  'pltf'
  'corp'
  'onln'
])
param parPlatformName string

@description('This parameter is a wrapper for creating the keyVaultName, but can be overwritten if needed')
param parNsgName string = 'nsg-${parPlatformName}-${parApplicationName}-${parEnvironment}'

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

param parDefaulSecurityRules array = []

// **resources**

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-09-01' = {
  name: parNsgName
  location: parLocation
  tags: parTags
  properties: {
    securityRules: parDefaulSecurityRules
  }
}

// **outputs**

output outputNetworkSecurityGroupName string = networkSecurityGroup.name
output outputNetworkSecurityGroupId string = networkSecurityGroup.id
