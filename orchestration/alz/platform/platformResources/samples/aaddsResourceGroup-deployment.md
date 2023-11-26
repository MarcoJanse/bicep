# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-aaddsRgDeploy'
  TemplateFile          = "orchestration\alz\platform\platformResources\platformResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\platformResources\aaddsResourceGroup.ictstuff.shd.bicepparams"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputObject -WhatIf
```
