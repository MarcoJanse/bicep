using 'platformResourceGroup.bicep'

param parEnvironment = 'shd'

param parPlatformName = 'pltf'

param parLocation = 'westeurope'

param parApplicationName = 'mgmt'

param parTags = {
  Application: 'Azure Landing Zone - Platform'
  Deployment: 'Bicep'
  Environment: 'shared'
  Owner: 'Marco Janse'
  RoleDescription: 'Platform management'
}
