@description('The region where to deploy the resources, default uses the region of the resource group referenced during deployment')
param location string = resourceGroup().location

@description('The user name of the SQL server administrator')
param sqlServerAdminUserName string = 'sqlAdmin'

@description('The password of the SQL administrator account. This should always be a secure parameter and never be a fixed value in your bicep file')
@secure()
param sqlServerAdminPassword string

@description('List of database names to deploy')
param sqlDatabases array = [
  'db1'
  'db2'
  'db3'
  'db4'
  'db5'
]

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: 'sql-3fifty'
  location: location
  properties: {
    administratorLogin: sqlServerAdminUserName
    administratorLoginPassword: sqlServerAdminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = [for sqlDatabase in sqlDatabases: {
  location: location
  name: sqlDatabase
  sku: {
    name: 'Standard'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
  }
  parent: sqlServer
}]
