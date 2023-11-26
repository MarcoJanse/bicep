using 'platformResources.bicep'

param parEnvironment = 'shd'

param parLocation = 'westeurope'

param parApplicationName = 'mgmt'

param parRegion = 'weu'

param parKeyVaultEnablePurgeProtection = true

param parKeyVaultEnableSoftDelete = true

param parStoragePublicAccess = 'Disabled'

param parTags = {
  Application: 'Azure Landing Zone - Platform'
  Deployment: 'Bicep'
  Environment: 'shared'
  Owner: 'Marco Janse'
  RoleDescription: 'Platform management'
}
