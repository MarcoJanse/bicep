# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-aaddsRgDeploy'
  TemplateFile          = "orchestration\alz\platform\managementResourceGroup\managementResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\managementResourceGroup\parameters\aaddsResourceGroup.parameters.ictstuff.shd.json"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputobject -WhatIf
```
