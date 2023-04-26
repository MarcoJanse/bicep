// **parameters**

@description('Provide the application name that will be used to generate the keyVault name')
@minLength(3)
@maxLength(4)
param parApplicationName string

@description('Provide the environment abbreviation this resource belongs to, like dev or prd')
@minLength(3)
@maxLength(3)
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

@description('The region abbreviation: gec for Germany Central, neu for North Europe, weu for West Europe, wus for West US')
@allowed([
  'gec'
  'neu'
  'weu'
  'wus'
])
param parRegion string

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

@description('The kind of storage account, like generic storage account type 2 or Blob storage')
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'StorageV2'
])
param parStorageKind string = 'StorageV2'

@description('Sets the public network access of the storage account to either Enabled or Disabled')
@allowed([
  'Disabled'
  'Enabled'
])
param parStoragePublicAccess string 

@description('The storage account name using defined naming convention and length')
@minLength(3)
@maxLength(24)
param parStorageAccountName string = 'stste${parApplicationName}${parEnvironment}${parRegion}'

// **variables**

var varStorageEnvironments = {
  dev: {
    sku: {
      name: 'Standard_LRS'
    }
  }
  tst: {
    sku: {
      name: 'Standard_LRS'
    }
  }
  acc: {
    sku: {
      name: 'Standard_LRS'
    }
  }
  prd: {
    sku: {
      name: 'Standard_GRS'
    }
  }
  shd: {
    sku: {
      name: 'Standard_GRS'
    }
  }
}

// **resources**

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: parStorageAccountName
  location: parLocation
  sku: varStorageEnvironments[parEnvironment].sku
  kind: parStorageKind
  tags: parTags
  properties: {
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: parStoragePublicAccess
    }
  }

// **outputs**

output outStorageAccountName string = storageAccount.name
output outStorageAccountId string = storageAccount.id
