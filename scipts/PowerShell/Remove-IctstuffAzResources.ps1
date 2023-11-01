#requires -module Az.Accounts, Az.Resources

# Quick and dirty script to remove all Bicep deployed resource groups.

$ResourceGroups = 
    'rg-app-avd-tst-001',
    'rg-lab-tst-001',
    'rg-app-aadds-shd-001',
    'rg-pltf-mgmt-shd-001',
    'rg-hubnetworking-shd-001',
    'NetworkWatcherRG',
    'rg-ascexportalz-shd-001',
    'rg-logging-shared-001',
    'DefaultResourceGroup-WEU'

foreach ($ResourceGroup in $ResourceGroups) {
    if (Get-AzResourceGroup $ResourceGroup -ErrorVariable NotExist -ErrorAction SilentlyContinue) {
        if ($NotExists) {
            Write-Warning "Resource Group $ResourceGroup does not exist"
        }
        else {
            try {
                Remove-AzResourceGroup -Name $ResourceGroup -Confirm:$false -Force
            }
            catch {
                 Write-Warning $Error[0]
            }
        }
    }
    else {
        Write-Warning "ResourceGroup $ResourceGroup does not exist"
    }
}