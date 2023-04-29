#requires -module Az.Accounts, Az.Resources

# Quick and dirty script to remove all Bicep deployed resource groups.

$ResourceGroups = 'rg-app-lzne-tst-001',
    'rg-app-mgmt-tst-001',
    'rg-lzde-spokenetworking-shd-001',
    'rg-lzne-spokenetworking-shd-001',
    'rg-pltf-mgmt-shd-001',
    'rg-hubnetworking-shd-001',
    'NetworkWatcherRG'

foreach ($ResourceGroup in $ResourceGroups) {
    Remove-AzResourceGroup -Name $ResourceGroup
}