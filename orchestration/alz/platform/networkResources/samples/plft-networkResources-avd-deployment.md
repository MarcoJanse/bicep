# Sample deployment: Platform network resources deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-nwAvdDeploy-{0}' -f (-join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  ResourceGroupName     = "rg-alz-connectivity"
  TemplateFile          = "orchestration\alz\platform\networkResources\pltf-networkResources.bicep"
  TemplateParameterFile = "orchestration\alz\platform\networkResources\pltf-networkResources.ictstuff.avd.bicepparam"
}
```

## Test deployment

```powershell
New-AzResourceGroupDeployment @inputobject -WhatIf
```
