#requires -Modules Az.Accounts,Az.Resources

# Script to remove implicit permissions for a specific account on management group structure.
# Only inherited permissions from the root management group are preserved.
# Useful to remove the account that created the managment group structure. 
#
# !!! Make sure this account is owner at the root management group before executing this !!!
#

$mgGroups = Get-AzManagementGroup | Where-Object DisplayName -NE 'Tenant Root Group'

[string]$upn = Read-Host -Prompt 'Enter the UserPrincipalName to remove the implicit permissions from the Management Group'

$results = foreach ($mgGroup in $mgGroups) {
    Get-AzRoleAssignment -Scope $mgGroup.Id -UserPrincipalName $upn | Where-Object Scope -ne '/'
}

foreach ($entry in $results) {
    Remove-AzRoleAssignment -SignInName $entry.SignInName -Scope $entry.Scope -RoleDefinitionName $entry.RoleDefinitionName
}