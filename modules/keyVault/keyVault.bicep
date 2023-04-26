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

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

@description('This parameter is a wrapper for creating the keyVaultName, but can be overwritten if needed')
param parKeyVaultName string = 'kv-${parApplicationName}-${parEnvironment}'

// **variables**

var varTenantId = tenant().tenantId

// **resources**

resource azKeyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: parKeyVaultName
  location: parLocation
  tags: parTags
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: varTenantId
    accessPolicies: [
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

// **outputs**

output outKeyVaultName string = azKeyVault.name
output outKeyVaultId string = azKeyVault.id
