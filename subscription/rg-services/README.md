<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_keyvault-dmn-tf-test"></a> [keyvault-dmn-tf-test](#module\_keyvault-dmn-tf-test) | ../../modules/key_vault | n/a |
| <a name="module_rg-services"></a> [rg-services](#module\_rg-services) | ../../modules/resource_group | n/a |
| <a name="module_sa00services"></a> [sa00services](#module\_sa00services) | ../../modules/storage_account | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_compliance_mode"></a> [compliance\_mode](#input\_compliance\_mode) | Shortcut: Set to true for Checkov scan, false for daily operations | `bool` | `false` | no |
| <a name="input_global_admin_object_id"></a> [global\_admin\_object\_id](#input\_global\_admin\_object\_id) | n/a | `string` | `"00000000-0000-0000-0000-000000000000"` | no |
| <a name="input_security_features"></a> [security\_features](#input\_security\_features) | Toggle security features for Checkov compliance vs operational access | <pre>object({<br/>    enable_public_network_access = bool # true = Zugriff möglich, false = Checkov compliant<br/>    enable_network_restrictions  = bool # true = Firewall-Regeln aktiv<br/>    enable_private_endpoints     = bool # true = Private Endpoints (kostet Geld!)<br/>    enable_cmk_encryption        = bool # true = Customer Managed Keys<br/>    # false = nur Entra ID / RBAC (empfohlen, CKV2_AZURE_40); true = Account-Keys + Key-SAS erlaubt<br/>    enable_shared_access_key = bool<br/>    # Logging — implemented in modules but default off (log storage / optional LA cost)<br/>    enable_blob_diagnostic_logs = bool<br/>  })</pre> | <pre>{<br/>  "enable_blob_diagnostic_logs": false,<br/>  "enable_cmk_encryption": false,<br/>  "enable_network_restrictions": false,<br/>  "enable_private_endpoints": false,<br/>  "enable_public_network_access": true,<br/>  "enable_shared_access_key": false<br/>}</pre> | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | `"00000000-0000-0000-0000-000000000000"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | ID of sa00services (e.g. for VNet flow log destination when enabled). |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Name of sa00services. |
<!-- END_TF_DOCS -->
