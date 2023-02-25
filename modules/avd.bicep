// parameters
@description('The Azre region to deploy to')
param location string

@description('The environment for the deployment')
@allowed([
  'dev'
  'test'
  'acc'
  'prod'
])
param env string

@description('The name of the AVD host pool')
param avdHostpoolName string

@description('The type of the AVD host pool, like personal or pooled')
@allowed([
  'BYODesktop'
  'Personal'
  'Pooled'
])
param avdHostpoolType string

@description('')
@allowed([
  'BreadthFirst'
  'DepthFirst'
  'Persistent'
])
param avdLoadbalancerType string

@description('The AVD publishing type, like Desktop or RailApplications')
@allowed([
  'Desktop'
  'None'
  'RailApplications'
])
param avdPreferredAppGroupType string

resource avd_hostpool 'Microsoft.DesktopVirtualization/hostPools@2022-09-09' = {
  name: avdHostpoolName
  location: location
  properties: {
    hostPoolType: avdHostpoolType
    loadBalancerType: avdLoadbalancerType
    preferredAppGroupType: avdPreferredAppGroupType
  }
}
