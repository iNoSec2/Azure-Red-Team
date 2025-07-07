Step-by-Step: Use an Azure Access Token with **management.azure.com**

Decoding Your Access Token
If you want to inspect your token and see what it allows, paste it into https://jwt.ms or https://jwt.io and check:
```
aud: Should be https://management.azure.com

scp or roles: Permissions like user_impersonation, Contributor, etc.

exp: Expiry time

cms_mirid: will give subscription id and resource access token has

OID: Account ID if management Identity
```

Prerequisites:
- You already have a valid access token for the https://management.azure.com resource.
- This could be from a service principal (client credentials), user authentication, or managed identity.

Example using `curl`:
```
curl -X GET https://management.azure.com/subscriptions?api-version=2020-01-01 \
  -H "Authorization: Bearer <your_access_token>" \
  -H "Content-Type: application/json"
```

Common Use Cases:
You can replace the URL to do things like:

List resource groups:
```
GET https://management.azure.com/subscriptions/{subscriptionId}/resourcegroups?api-version=2021-04-01
```


Get info on a VM:
```
GET https://management.azure.com/subscriptions/{subscriptionId}/resourceGroups/{rg}/providers/Microsoft.Compute/virtualMachines/{vm}?api-version=2021-03-01
```

Listing out Keyvaults:
```
https://management.azure.com/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/vaults?api-version=2019-09-01
```

URL Reference: https://learn.microsoft.com/en-us/powershell/module/az.accounts/get-azaccesstoken?view=azps-14.2.0

Get Tokens for other areas once authenticated into Connect-AzAccount
```
Get-AzAccessToken -AsSecureString -ResourceTypeName MSGraph
Get-AzAccessToken -AsSecureString -ResourceUrl "https://graph.microsoft.com/"
Get-AzAccessToken -AsSecureString -ResourceUrl "https://graph.windows.net/"  
```



URL Refrence: https://learn.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount?view=azps-14.1.0



## General Recon 

Connect-AzAccount with AccessToken:

```
Connect-AzAccount -AccessToken
```

Connect to a specific subscription:
```
Connect-AzAccount -AccessToken <access_token> --Subscription <subscription_id>
```

Once you're authenticated with Connect-AzAccount (via PowerShell), you're essentially authenticated to interact with the Azure Resource Manager (ARM) API. Below are some reconnaissance (recon) commands you can run to gather information about your Azure environment, resources, and configurations.

These commands are useful for gathering metadata, resource details, and overall status within your subscription. They can be used for security audits, reporting, or just exploring what's in your Azure environment.

List Subscriptions
You can view all subscriptions you have access to:
```
Get-AzSubscription
```

This command shows all subscriptions and your current active subscription.

To set a particular subscription as active:
```
Set-AzContext -SubscriptionId <SubscriptionId>
```

Get Resource Groups
This will list all the resource groups in your current active subscription:

```
Get-AzResourceGroup
```


You can also filter by location:
```
Get-AzResourceGroup | Where-Object { $_.Location -eq "East US" }
```

Get All Resources
List all resources (VMs, networks, storage accounts, etc.) in the subscription:
```
Get-AzResource
```

To list resources within a specific resource group:
```
Get-AzResource -ResourceGroupName <ResourceGroupName>
```

List Virtual Machines
To list all the VMs in the current subscription:
```
Get-AzVM
```

For details about a specific VM:
```
Get-AzVM -ResourceGroupName <ResourceGroupName> -Name <VMName>
```

Get Network Information
To list all the virtual networks:
```
Get-AzVirtualNetwork
```


For a specific virtual network:
```
Get-AzVirtualNetwork -Name <VNetName> -ResourceGroupName <ResourceGroupName>
```

To list all network interfaces:
```
Get-AzNetworkInterface
```

List Storage Accounts
To get all storage accounts in your subscription:
```
Get-AzStorageAccount
```


For a specific storage account:
```
Get-AzStorageAccount -ResourceGroupName <ResourceGroupName> -Name <StorageAccountName>
```


List Azure Active Directory (AAD) Roles and Role Assignments
To get all role assignments (who has access to what):
```
Get-AzRoleAssignment
```

To filter by a specific resource group:
```
Get-AzRoleAssignment -ResourceGroupName <ResourceGroupName>
```

You can also filter by user, for example:
```
Get-AzRoleAssignment -SignInName <user@example.com>
```

List Managed Identities
To list all managed identities:
```
Get-AzUserAssignedIdentity
```

