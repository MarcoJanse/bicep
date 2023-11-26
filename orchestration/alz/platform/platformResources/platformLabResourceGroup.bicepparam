using 'platformResourceGroup.bicep'

param parEnvironment = 'tst'

param parPlatformName = 'pltf'

param parLocation = 'westeurope'

param parApplicationName = 'lab'

param parTags = {
  Application: 'Azure Landing Zone - Platform'
  Deployment: 'Bicep'
  Environment: 'test'
  Owner: 'Marco Janse'
  RoleDescription: 'Lab resources'
}
