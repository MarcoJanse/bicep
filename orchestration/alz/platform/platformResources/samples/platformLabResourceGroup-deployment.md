# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-labRgDeploy'
  TemplateFile          = "orchestration\alz\platform\platformResources\platformResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\platformResources\platformLabResourceGroup.bicepparam"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputObject -WhatIf
```
