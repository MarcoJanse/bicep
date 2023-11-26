using 'pltf-networkResources.bicep'

param parEnvironment = 'shd'

param parLocation = 'westeurope'

param parApplicationName = 'adds'

param parPlatformName = 'pltf'

param parVnetName = 'vnet-hub-weu'

param parVnetSubnetAddressPrefix = '172.20.1.0/24'

param parTags = {
  Application: 'Networking'
  Deployment: 'Bicep'
  Environment: 'Shared'
  Owner: 'Marco Janse'
  RoleDescription: 'Azure Active Directory Services Subnet'
}
