# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-avdRgDeploy'
  TemplateFile          = "orchestration\alz\platform\platformResources\platformResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\platformResources\\avdResourceGroup.parameters.ictstuff.tst.json"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputObject -WhatIf
```
