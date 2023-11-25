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
param parKeyVaultName string = 'kv-ictstuff-${parApplicationName}-${parEnvironment}'

@description('Sets the Key Vault purge protection')
param parKeyVaultEnablePurgeProtection bool

@description('Sets the Key Vault soft delete')
param parKeyVaultEnableSoftDelete bool

@description('The region abbreviation: neu for North Europe, weu for West Europe, wus for West US')
@allowed([
  'neu'
  'weu'
  'wus'
])
param parRegion string

@description('Sets the public network access of the storage account to either Enabled or Disabled')
@allowed([
  'Disabled'
  'Enabled'
])
param parStoragePublicAccess string 

@description('The storage account name using defined naming convention and length')
@minLength(3)
@maxLength(24)
param parStorageAccountName string = 'stictstuff${parApplicationName}${parEnvironment}${parRegion}${padLeft(1, 3, '0')}'

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **resources**

// **modules**

module KeyVault '../../../../modules/keyVault/keyVault.bicep' = {
  name: '${deployment().name}-keyVaultdeploy'
  params: {
    parApplicationName: parApplicationName
    parEnvironment: parEnvironment
    parKeyVaultName: '${parKeyVaultName}-${padLeft(1, 3, '0')}'
    parLocation: parLocation
    parKeyVaultEnablePurgeProtection: parKeyVaultEnablePurgeProtection
    parKeyVaultEnableSoftDelete: parKeyVaultEnableSoftDelete
    parTags: parTags
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
