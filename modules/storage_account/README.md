<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_monitor_diagnostic_setting.blob](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.data_plane](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_queue_properties.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_queue_properties) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_share.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Replikationstyp des Storage Accounts (z. B. LRS, GRS, ZRS). | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Performance-Tier des Storage Accounts (Standard oder Premium). | `string` | `"Standard"` | no |
| <a name="input_allow_blob_public_access"></a> [allow\_blob\_public\_access](#input\_allow\_blob\_public\_access) | Allow anonymous public access to blobs | `bool` | `false` | no |
| <a name="input_data_plane_principal_id"></a> [data\_plane\_principal\_id](#input\_data\_plane\_principal\_id) | Entra object ID that gets storage data-plane RBAC when shared keys are disabled. Null skips role assignments. | `string` | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | Prefer OAuth/Entra auth in Azure portal and compatible clients (does not replace disabling shared keys). | `bool` | `true` | no |
| <a name="input_diagnostic_log_storage_account_id"></a> [diagnostic\_log\_storage\_account\_id](#input\_diagnostic\_log\_storage\_account\_id) | Destination storage account for blob diagnostics. Null = this account. Only used when enable\_blob\_diagnostic\_logs is true. | `string` | `null` | no |
| <a name="input_enable_blob_diagnostic_logs"></a> [enable\_blob\_diagnostic\_logs](#input\_enable\_blob\_diagnostic\_logs) | When true, create monitor diagnostic settings for blob StorageRead/Write/Delete (log storage costs). Default off for free lab. | `bool` | `false` | no |
| <a name="input_file_shares"></a> [file\_shares](#input\_file\_shares) | Liste der zu erstellenden File Shares. | <pre>list(object({<br/>    name        = string<br/>    quota       = number<br/>    access_tier = optional(string, "Hot")<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure Region, in der der Storage Account erstellt wird. | `string` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Allow public network access | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name der Resource Group, in der der Storage Account erstellt wird. | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Allow Shared Key / account-key SAS. Prefer false (Entra ID + RBAC) for learning/security. | `bool` | `false` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name des Storage Accounts (global eindeutig, nur Kleinbuchstaben und Zahlen). | `string` | n/a | yes |
| <a name="input_storage_containers"></a> [storage\_containers](#input\_storage\_containers) | Liste der zu erstellenden Storage Container. | <pre>list(object({<br/>    name                  = string<br/>    container_access_type = optional(string, "private")<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags für die Ressourcen. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_file_share_ids"></a> [file\_share\_ids](#output\_file\_share\_ids) | IDs der erstellten File Shares. |
| <a name="output_file_share_names"></a> [file\_share\_names](#output\_file\_share\_names) | Namen der erstellten File Shares. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | ID des erstellten Storage Accounts. |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Name des erstellten Storage Accounts. |
| <a name="output_storage_container_ids"></a> [storage\_container\_ids](#output\_storage\_container\_ids) | IDs der erstellten Storage Container. |
| <a name="output_storage_container_names"></a> [storage\_container\_names](#output\_storage\_container\_names) | Namen der erstellten Storage Container. |
<!-- END_TF_DOCS -->
