using 'platformResourceGroup.bicep'

param parEnvironment = 'shd'

param parPlatformName = 'app'

param parLocation = 'westeurope'

param parApplicationName = 'aadds'

param parTags = {
  Application: 'ADDS'
  Deployment: 'Bicep'
  Environment: 'shared'
  Owner: 'Marco Janse'
  RoleDescription: 'Azure Active Directory Domain Services'
}
