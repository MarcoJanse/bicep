#requires -module Az.Accounts, Az.Resources

# This script can be used for removing all unknown identities that were deployed by ALZ policy assignments.
# After you remove the policy assignments, the role assignments survice, but become unknown identities 

$mg = Get-AzManagementGroup | 
    Where-Object { $_.Name -ne '2ee97048-b89c-40e2-a1d9-8741c456f37b' } |
    Select-Object -ExpandProperty id |
    Sort-Object Length


foreach ($group in $mg) {
    Get-AzRoleAssignment -Scope $group | Where-Object ObjectType -eq 'Unknown' |
    Remove-AzRoleAssignment
}