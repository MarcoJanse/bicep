using 'pltf-networkResources.bicep'

param parEnvironment = 'tst'

param parLocation = 'westeurope'

param parApplicationName = 'workload'

param parPlatformName = 'pltf'

param parVnetName = 'vnet-hub-weu'

param parVnetSubnetAddressPrefix = '172.20.20.0/24'

param parTags = {
  Application: 'Networking'
  Deployment: 'Bicep'
  Environment: 'Test'
  Owner: 'Marco Janse'
  RoleDescription: 'Workload subnet'
}
