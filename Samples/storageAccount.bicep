param location string = resourceGroup().location

param storageAccountNames array = [
  'sta3fiftyblog2023'
  'sta3fiftyblog2022'
  'sta3fiftyblog2021'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
  location: location
  sku: {
    name: 'Premium_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Enabled'
    }
}]

output deployedStorageAccountNames array = [for storageAccountName in storageAccountNames: {
  storageAccountId: storageAccountName.id
}]
