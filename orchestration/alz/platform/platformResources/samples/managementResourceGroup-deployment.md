# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-mgmtRgDeploy'
  TemplateFile          = "orchestration\alz\platform\platformResources\platformResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\platformResources\managementResourceGroup.parameters.ictstuff.shd.json"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputObject -WhatIf
```
