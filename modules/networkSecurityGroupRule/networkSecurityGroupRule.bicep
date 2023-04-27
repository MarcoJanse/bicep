// ** parameters**

@description('Provide the name of the Network Security Group (NSG)')
param parNsgName string

@description('Provide one of more NSG security rules')
param parNsgRules array

// **resources**

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-07-01' existing = {
  name: parNsgName
}

resource networkSecurityGroupRules 'Microsoft.Network/networkSecurityGroups/securityRules@2022-07-01' = [for rule in parNsgRules: {
  name: '${networkSecurityGroup}/${rule.name}'
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
