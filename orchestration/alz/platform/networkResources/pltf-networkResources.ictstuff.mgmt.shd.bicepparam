using 'pltf-networkResources.bicep'

param parEnvironment = 'shd'

param parLocation = 'westeurope'

param parApplicationName = 'mgmt'

param parPlatformName = 'pltf'

param parVnetName = 'vnet-hub-weu'

param parVnetSubnetAddressPrefix = '172.20.2.0/24'

param parTags = {
  Application: 'Networking'
  Deployment: 'Bicep'
  Environment: 'shared'
  Owner: 'Marco Janse'
  RoleDescription: 'Workload subnet'
}
