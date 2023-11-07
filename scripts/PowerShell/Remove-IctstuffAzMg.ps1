#requires -module Az.Accounts, Az.Resources

$mg = Get-AzManagementGroup | 
    Where-Object { $_.Name -ne '2ee97048-b89c-40e2-a1d9-8741c456f37b' } |
    Select-Object -ExpandProperty Name |
    Sort-Object Length -Descending
    

foreach ($group in $mg){
    Remove-AzManagementGroup -GroupName $group -Verbose
}