// **parameters**

@description('Provide the environment abbreviation this resource belongs to, like dev or prd')
@allowed([
  'dev'
  'tst'
  'acc'
  'prd'
  'shd'
])
param parEnvironment string

@description('Provide the Azure region this resource will be deployed to. By default it uses the resource group location')
param parLocation string

@description('Provide the application name that will be used to generate the resource group name')
param parApplicationName string

@description('The name of the Virtual Network (vNet) to reference')
param parVnetName string

@description('The name of the subnet the VMs network interface should be connected to')
param parVnetSubnetName string

param parNsgName string

param parVmName string = 'vm${parApplicationName}${parEnvironment}${padLeft(1, 2, '0')}'

@allowed([
  'standard_B2s'
  'standard_DS1_v2'
  'standard_D2s_v3'
  'standard_D4s_v3'
])
param parVmSize string = 'standard_B2s'

@description('Specify if the network interface should be enabled for accelerated networking. NOTE: the B-series VMs do not support accelerated networking')
param parNicEnableAccelleratedNetworking bool

@allowed([
  'Dynamic'
  'Static'
])
param parVmIpAllocationMethod string

@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'PremiumV2_LRS'
  'Standard_LRS'
  'StandardSSD_LRS'
  'StandardSSD_ZRS'
  'UltraSSD_LRS'
])
param parVmOsDiskSku string = 'Premium_LRS'

@allowed([
  'detach'
  'delete'
])
param parVmOsDiskDeleteOption string

@description('Look at the available image offers using "Get-AzVMImagePublisher"')
@allowed([
  'Canonical'
  'MicrosoftWindowsDesktop'
  'MicrosoftWindowsServer'
])
param parVmOsDiskImagePublisher string = 'MicrosoftWindowsServer'

@description('Look at the available image offers using "Get-AzVMImageOffer"')
@allowed([
  'WindowsServer'
])
param parVmOsDiskImageOffer string = 'WindowsServer'

@description('')
@allowed([
  '2022-datacenter-azure-edition'
  '2022-datacenter-azure-edition-core'
  '2022-datacenter-azure-edition-core-smalldisk'
  '2019-Datacenter'
  '2019-datacenter-core-g2'
  '2019-datacenter-core-smalldisk-g2'
])
param parVmOsDiskImageSku string

param parVmDataDiskRequired bool

param parVmDataDiskSize int

@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'PremiumV2_LRS'
  'Standard_LRS'
  'StandardSSD_LRS'
  'StandardSSQ_ZRS'
  'UltraSSD_LRS'
])
param parVmDataDiskSku string

param parVmDataDiskZone string

@description('This creates a tags object that can be used in parent Bicep file to add tags')
param parTags object = {}

// **resources**

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' existing = {
  name: parVnetName
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-05-01' existing = {
  name: parNsgName
}

resource vmPrimaryNetworkInterface 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: 'nic-${parVmName}-${padLeft(1, 2, '0')}'
  location: parLocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: parVnetSubnetName
          }
          privateIPAllocationMethod: parVmIpAllocationMethod
        }
      }
    ]
    enableAcceleratedNetworking: parNicEnableAccelleratedNetworking
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
  tags: parTags
}

resource vmDataDisk 'Microsoft.Compute/disks@2023-04-02' = if (parVmDataDiskRequired) {
  name: 'disk-${parVmName}-data-${padLeft(1, 3, '0')}'
  location: parLocation
  sku: {
    name: parVmDataDiskSku
  }
  properties: {
    diskSizeGB: parVmDataDiskSize
    creationData: {
      createOption: 'empty'
    }
  }
  zones: [
    parVmDataDiskZone
  ]
  tags: parTags
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: parVmName
  location: parLocation
  properties: {
    hardwareProfile: {
      vmSize: parVmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: parVmOsDiskSku
        }
        deleteOption: parVmOsDiskDeleteOption
      }
      imageReference: {
        publisher: parVmOsDiskImagePublisher
        offer: parVmOsDiskImageOffer
        sku: parVmOsDiskImageSku
      }
    }
  }
}
