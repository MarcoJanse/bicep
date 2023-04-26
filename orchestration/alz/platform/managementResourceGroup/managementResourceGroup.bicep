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
  'pltf'
  'lznl'
  'app'
])
param parPlatform string

@description('Provide the Azure region this resource will be deployed to.')
param parLocation string

@description('Provide the application name that will be used to generate the resource group name')
param parApplicationName string

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **Resources**

// **Modules**

module ResourceGroup '../../../../modules/resourceGroup/resourceGroup.bicep' = {
  name: '${deployment().name}-rgDeploy'
  params: {
    parResourceGroupName: 'rg-${parPlatform}-${parApplicationName}-${parEnvironment}-${padLeft(1, 3, '0')}'
    parLocation: parLocation
    parEnvironment: parEnvironment
    parApplicationName: parApplicationName
    parPlatform: parPlatform
    parTags: parTags
  }
}
