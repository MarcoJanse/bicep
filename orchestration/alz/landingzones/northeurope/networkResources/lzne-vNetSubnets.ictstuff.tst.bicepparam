using 'lzne-vNetSubnets.bicep'

param parApplicationName = 'workload'

param parEnvironment = 'tst'

param parPlatformName = 'lzne'

param parVnetName = 'vnet-spoke-neu'

param parVnetSubnetAddressPrefix = '172.21.20.0/24'

param parTags = {
  Application: 'Azure Landing Zone - North Europe'
  Country: 'Germany'
  Deployment: 'Bicep'
  Environment: 'Test'
  Owner: 'Marco Janse'
}
