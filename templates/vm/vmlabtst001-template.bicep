param location string
param networkInterfaceName1 string
param subnetName string
param virtualNetworkId string
param virtualMachineName string
param virtualMachineName1 string
param virtualMachineComputerName1 string
param virtualMachineRG string
param osDiskType string
param osDiskDeleteOption string
param virtualMachineSize string
param nicDeleteOption string
param hibernationEnabled bool
param adminUsername string

@secure()
param adminPassword string

param patchMode string
param enableHotpatching bool
param rebootSetting string
param securityType string
param secureBoot bool
param vTPM bool
param virtualMachine1Zone string
param autoShutdownStatus string
param autoShutdownTime string
param autoShutdownTimeZone string
param autoShutdownNotificationStatus string
param autoShutdownNotificationLocale string
param autoShutdownNotificationEmail string

var vnetId = virtualNetworkId
var vnetName = last(split(vnetId, '/'))
var subnetRef = '${vnetId}/subnets/${subnetName}'

resource networkInterface1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName1
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
  tags: {
    Owner: 'Marco Janse'
    Environment: 'Test'
    RoleDescription: 'Test Windows VM'
    CreateDate: '2023-11-26'
  }
  dependsOn: []
}

resource virtualMachine1 'Microsoft.Compute/virtualMachines@2022-11-01' = {
  name: virtualMachineName1
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'fromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: osDiskDeleteOption
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition-core-smalldisk'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface1.id
          properties: {
            deleteOption: nicDeleteOption
          }
        }
      ]
    }
    securityProfile: {
      encryptionAtHost: true
      securityType: securityType
      uefiSettings: {
        secureBootEnabled: secureBoot
        vTpmEnabled: vTPM
      }
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    osProfile: {
      computerName: virtualMachineComputerName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
        patchSettings: {
          enableHotpatching: enableHotpatching
          patchMode: patchMode
          automaticByPlatformSettings: {
            rebootSetting: rebootSetting
          }
        }
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
  tags: {
    Owner: 'Marco Janse'
    Environment: 'Test'
    RoleDescription: 'Test Windows VM'
    CreateDate: '2023-11-26'
  }
  zones: [
    virtualMachine1Zone
  ]
}

resource shutdown_computevm_virtualMachine1 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: 'shutdown-computevm-${virtualMachineName1}'
  location: location
  properties: {
    status: autoShutdownStatus
    taskType: 'ComputeVmShutdownTask'
    dailyRecurrence: {
      time: autoShutdownTime
    }
    timeZoneId: autoShutdownTimeZone
    targetResourceId: virtualMachine1.id
    notificationSettings: {
      status: autoShutdownNotificationStatus
      notificationLocale: autoShutdownNotificationLocale
      timeInMinutes: '30'
      emailRecipient: autoShutdownNotificationEmail
    }
  }
  tags: {
    Owner: 'Marco Janse'
    Environment: 'Test'
    RoleDescription: 'Test Windows VM'
    CreateDate: '2023-11-26'
  }
}

output adminUsername string = adminUsername
