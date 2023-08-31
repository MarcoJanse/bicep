using 'pltf-networkResources.bicep'

param parEnvironment = 'prd'

param parLocation = 'westeurope'

param parApplicationName = 'workload'

param parPlatformName = 'pltf'

param parVnetName = 'vnet-hub-weu'

param parVnetSubnetAddressPrefix = '172.20.40.0/24'

param parTags = {
  Application: 'Networking'
  Deployment: 'Bicep'
  Environment: 'Production'
  Owner: 'Marco Janse'
  RoleDescription: 'Workload subnet'
}
