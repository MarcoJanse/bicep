# Sample deployment: Platform network resources deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-nwAvdDeploy-{0}' -f (-join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  ResourceGroupName     = "rg-hubnetworking-shd-001"
  TemplateFile          = "orchestration\alz\platform\networkResources\pltf-networkResources.bicep"
  TemplateParameterFile = "orchestration\alz\platform\networkResources\parameters\pltf-networkResources.parameters.ictstuff.avd.json"
}
```

## Test deployment

```powershell
New-AzResourceGroupDeployment @inputobject -WhatIf
```
