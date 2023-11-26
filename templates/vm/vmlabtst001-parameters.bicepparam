using './vmlabtst001-template.bicep'

param location = 'westeurope'

param networkInterfaceName1 = 'vmlabtst001432_z1'

param subnetName = 'snet-pltf-work-tst'

param virtualNetworkId = '/subscriptions/b89c0508-fa65-459a-a4fa-7e3b1c907671/resourceGroups/rg-alz-connectivity/providers/Microsoft.Network/virtualNetworks/vnet-hub-weu'

param virtualMachineName = 'vmlabtst001'

param virtualMachineName1 = 'vmlabtst001'

param virtualMachineComputerName1 = 'vmlabtst001'

param virtualMachineRG = 'rg-pltf-lab-tst-001'

param osDiskType = 'Premium_LRS'

param osDiskDeleteOption = 'Delete'

param virtualMachineSize = 'Standard_B2s'

param nicDeleteOption = 'Delete'

param hibernationEnabled = false

param adminUsername = 'ictstuffadm'

param adminPassword = null

param patchMode = 'AutomaticByPlatform'

param enableHotpatching = true

param rebootSetting = 'IfRequired'

param securityType = 'TrustedLaunch'

param secureBoot = true

param vTPM = true

param virtualMachine1Zone = '1'

param autoShutdownStatus = 'Enabled'

param autoShutdownTime = '19:00'

param autoShutdownTimeZone = 'W. Europe Standard Time'

param autoShutdownNotificationStatus = 'Enabled'

param autoShutdownNotificationLocale = 'en'

param autoShutdownNotificationEmail = 'marco.janse@ictstuff.info'