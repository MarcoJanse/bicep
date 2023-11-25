# Sample deployment: Management Resource Group deployment

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-avdRgDeploy'
  TemplateFile          = "orchestration\alz\platform\managementResourceGroup\managementResourceGroup.bicep"
  Location              = "westeurope"
  TemplateParameterFile = "orchestration\alz\platform\managementResourceGroup\parameters\avdResourceGroup.parameters.ictstuff.tst.json"
}
```

## Test deployment

```powershell
New-AzSubscriptionDeployment @inputobject -WhatIf
```
