// **parameters**

@description('The Azure region to deploy to')
param location string

@description('The environment for the deployment')
@allowed([
  'dev'
  'test'
  'acc'
  'prod'
])
param env string

@description('Enter the prefix that will be used for the session host name')
param avdSessionHostPrefix string = 'avd${env}weu'

@description('Please provide the domain name that the Azure Virtual Desktop hosts will be joined to')
param domainName string

@description('The name of the AVD host pool')
param avdHostpoolName string

@description('The type of the AVD host pool, like personal or pooled')
@allowed([
  'BYODesktop'
  'Personal'
  'Pooled'
])
param avdHostPoolType string

@description('')
@allowed([
  'BreadthFirst'
  'DepthFirst'
  'Persistent'
])
param avdHostPoolLoadbalancerType string

@description('The AVD publishing type, like Desktop or RailApplications')
@allowed([
  'Desktop'
  'None'
  'RailApplications'
])
param avdHostPoolPreferredAppGroupType string

@description('placeholder for applying tags to resources during deployment')
param tags object = {}

@description('Please specify the maximum sessions for the host pool')
param avdHostPoolMaxSessionLimit int

@description('Please specify if this hostpool is a validation environment for installing and testing updates')
param avdHostPoolValidationEnvironment bool

param avdSessionHostImage object = {
  ImageOffer: 'office-365'
  galleryImageSKU: 'win11-22h2-avd-m365'
  galleryItemId: 'Microsoftwindowsdesktop.office-365win11-22h2-avd-m365'
}

param avdSessionHostSize object = {
  osDiskType: 'StandardSSD_LRS'
  vmSize: 'Standard_DS1_v2'
  cores: 1
  ram: '3.5'
}

param avdSessionHostConfig object = {
secureBoot: 'false'
  vTPM: 'false'
}

// **Variables**

@description('Used for custom RDP properties')
var avdHostPoolCustomRdpProperty = 'drivestoredirect:s:;audiomode:i:0;videoplaybackmode:i:1;redirectclipboard:i:1;redirectprinters:i:1;devicestoredirect:s:*;redirectcomports:i:0;redirectsmartcards:i:1;usbdevicestoredirect:s:;enablecredsspsupport:i:1;redirectwebauthn:i:1;use multimon:i:1;autoreconnection enabled:i:1;'

@description('VM template for sessionhosts configuration within hostpool.')
var avdHostPoolTemplate = '{"domain":"${domainName}","galleryImageOffer":"${avdSessionHostImage.ImageOffer}","galleryImagePublisher":"microsoftwindowsdesktop","galleryImageSKU":"${avdSessionHostImage.galleryImageSKU}","imageType":"Gallery","customImageId":null,"namePrefix":"${avdSessionHostPrefix}","osDiskType":"${avdSessionHostSize.osDiskType}","vmSize":{"id":"${avdSessionHostSize.vmSize}","cores":${avdSessionHostSize.cores},"ram":${avdSessionHostSize.ram},"rdmaEnabled":false,"supportsMemoryPreservingMaintenance":true},"galleryItemId":"${avdSessionHostImage.galleryItemId}","hibernate":false,"diskSizeGB":0,"securityType":"Standard","secureBoot":${avdSessionHostConfig.secureBoot},"vTPM":${avdSessionHostConfig.vTPM}}'

// **Resources**

resource avd_hostpool 'Microsoft.DesktopVirtualization/hostPools@2022-09-09' = {
  name: avdHostpoolName
  location: location
  properties: {
    hostPoolType: avdHostPoolType
    loadBalancerType: avdHostPoolLoadbalancerType
    preferredAppGroupType: avdHostPoolPreferredAppGroupType
    customRdpProperty: avdHostPoolCustomRdpProperty
    maxSessionLimit: avdHostPoolMaxSessionLimit
    validationEnvironment: avdHostPoolValidationEnvironment
    vmTemplate: avdHostPoolTemplate
  }
  tags: tags
}
