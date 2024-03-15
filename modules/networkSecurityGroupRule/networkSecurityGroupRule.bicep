// ** parameters**

@description('Provide the name of the Network Security Group (NSG)')
param parNsgName string

@description('Provide one or more NSG security rules')
param parNsgRules array

// **resources**

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-09-01' existing = {
  name: parNsgName
}

resource networkSecurityGroupRules 'Microsoft.Network/networkSecurityGroups/securityRules@2023-09-01' = [for rule in parNsgRules: {
  parent: networkSecurityGroup
  name: '${rule.name}'
  properties: {
    protocol: rule.protocol
    sourcePortRange: rule.sourcePortRange
    destinationPortRange: rule.destinationPortRange
    sourceAddressPrefix: rule.sourceAddressPrefix
    destinationAddressPrefix: rule.destinationAddressPrefix
    access: rule.access
    priority: rule.priority
    direction: rule.direction
  }
}]
