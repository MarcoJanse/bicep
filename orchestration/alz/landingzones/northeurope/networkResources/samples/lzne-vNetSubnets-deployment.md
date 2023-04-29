# Sample deployment: Landing Zone North Europe subnet deployments

> **NOTE** The example below deploys the tst subnet, nsg and rules. To deploy the other environments, just change the `TemplateParameterFile` parameter

## Prepare hash table with parameters

```powershell
$inputObject = @{
  DeploymentName        = 'ictstuff-lzneNwDeploy-{0}' -f (-join (Get-Date -Format 'yyyyMMddTHHMMssffffZ')[0..63])
  ResourceGroupName     = "rg-lzne-spokenetworking-shd-001"
  TemplateFile          = "orchestration\alz\landingzones\northeurope\networkResources\lzne-vNetSubnets.bicep"
  TemplateParameterFile = "orchestration\alz\landingzones\northeurope\networkResources\parameters\lzne-vNetSubnets.parameters.ictstuff.tst.json"
}
```

## Test deployment

```powershell
New-AzResourceGroupDeployment @inputobject -WhatIf
```

## Deploy and watch

```powershell
New-AzResourceGroupDeployment @inputobject -Verbose
```
