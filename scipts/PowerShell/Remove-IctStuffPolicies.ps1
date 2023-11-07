#requires -module Az.Accounts, Az.Resources

# Target Management Group
$mgName = 'alz-mg'

# Remove Azure Policy Assignments
$azManagementGroupIds = Get-AzManagementGroup | Select-Object -ExpandProperty Id

foreach ($managementGroupId in $azManagementGroupIds) {
    Get-AzPolicyAssignment -Scope $managementGroupId | Remove-AzPolicyAssignment
}

# Remove Azure Policy Initiatives
Get-AzPolicySetDefinition -Custom -ManagementGroupName $mgName | Remove-AzPolicySetDefinition -Confirm:$false -Force -Verbose

# Remove Azure Policy Definitions
Get-AzPolicyDefinition -Custom -ManagementGroupName $mgName | Remove-AzPolicyDefinition -Confirm:$false -Force -Verbose