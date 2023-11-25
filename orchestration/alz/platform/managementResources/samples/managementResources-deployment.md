# Sample deployment: Management Resources deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-mgmtDeploy-{0}' -f (-join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  ResourceGroupName     = "rg-pltf-mgmt-shd-001"
  TemplateFile          = "orchestration\alz\platform\managementResources\managementResources.bicep"
  TemplateParameterFile = "orchestration\alz\platform\managementResources\managementResources.ictstuff.shd.bicepparam"
}
```

## Test deployment

```powershell
New-AzResourceGroupDeployment @inputobject -WhatIf
```
