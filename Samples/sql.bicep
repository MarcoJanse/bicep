// parameters

@description('The region where to deploy the resources, default uses the region of the resource group referenced during deployment')
param location string = resourceGroup().location

@description('The environment to deploy, like test,dev or prod')
@allowed([
  'test'
  'acc'
  'demo'
  'prod'
  'dev'
])
param env string

@description('The department that owns the resource')
param owner string = 'Research'

@description('The name that will be used to generate the SQL server instance name')
param name string = 'contoso'

@description('The user name of the SQL server administrator')
param sqlServerAdminUserName string

@description('The password of the SQL administrator account. This should always be a secure parameter and never be a fixed value in your bicep file')
@secure()
param sqlServerAdminPassword string

param sqlDatabases array = [
  'db1'
  'db2'
  'db3'
  'db4'
  'db5'
]

param sqlDbCollation string = 'SQL_Latin1_General_CP1_CI_AS'

// variables

var sqlTiers = {
  test: {
      tier: 'Standard'
  }
  dev: {
    tier: 'Standard'
  }
  acc: {
      tier: 'Standard'
  }
  prod: {
      tier: 'Premium'
  }
}

@description('The tags to apply to each resource')
param tags object = {
  environment: env
  owner: owner
}

// resources

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: 'sql-${name}-${env}'
  location: location
  properties: {
    administratorLogin: sqlServerAdminUserName
    administratorLoginPassword: sqlServerAdminPassword
  }
  tags: tags
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = [for sqlDatabase in sqlDatabases: {
  location: location
  name: 'sqldb-${sqlDatabase}-${env}'
  sku: sqlTiers[env]
  properties: {
    collation: sqlDbCollation
  }
  parent: sqlServer
  tags: tags
}]
