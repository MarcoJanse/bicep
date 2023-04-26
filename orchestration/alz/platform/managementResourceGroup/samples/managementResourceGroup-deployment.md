# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-mgmtRgDeploy'
  TemplateFile          = "orchestration\platform\managementResourceGroup\managementResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\platform\managementResourceGroup\parameters\managementResourceGroup.parameters.ictstuff.shd.json"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputobject -WhatIf
```
