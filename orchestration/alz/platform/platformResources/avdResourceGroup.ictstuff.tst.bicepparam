using 'platformResourceGroup.bicep'

param parEnvironment = 'tst'

param parPlatformName = 'app'

param parLocation = 'westeurope'

param parApplicationName = 'avd'

param parTags = {
  Application: 'AVD'
  Deployment: 'Bicep'
  Environment: 'Test'
  Owner: 'Marco Janse'
  RoleDescription: 'Azure Virtual Desktop'
}
