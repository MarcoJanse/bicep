targetScope = 'subscription'

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

@description('Provide the content for deployment, like "pltf" for platform, lzxx for landingzone country or "app" for application')
@allowed([
  'app'
  'pltf'
  'lzne'
  'lzde'
])
param parPlatformName string

@description('Provide the Azure region this resource will be deployed to. By default it uses the resource group location')
param parLocation string

@description('Provide the application name that will be used to generate the resource group name')
param parApplicationName string

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

param parResourceGroupName string = 'rg-${parPlatformName}-${parApplicationName}-${parEnvironment}'

// **resources**

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: parResourceGroupName
  location: parLocation
  tags: parTags
}

// **outputs**

output outResourceGroupId string = resourceGroup.id
output outResourceGroupName string = resourceGroup.name
