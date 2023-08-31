using 'pltf-networkResources.bicep'

param parEnvironment = 'acc'

param parLocation = 'westeurope'

param parApplicationName = 'workload'

param parPlatformName = 'pltf'

param parVnetName = 'vnet-hub-weu'

param parVnetSubnetAddressPrefix = '172.20.30.0/24'

param parTags = {
  Application: 'Networking'
  Deployment: 'Bicep'
  Environment: 'Acceptance'
  Owner: 'Marco Janse'
  RoleDescription: 'Workload subnet'
}
