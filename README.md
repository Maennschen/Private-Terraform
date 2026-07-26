<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.15.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_subscription"></a> [subscription](#module\_subscription) | ./subscription | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_global_admin_object_id"></a> [global\_admin\_object\_id](#input\_global\_admin\_object\_id) | Entra object ID (user or group) for storage data-plane RBAC and Key Vault access. Set via terraform.tfvars (gitignored) or TF\_VAR\_global\_admin\_object\_id. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Azure subscription ID. Set via terraform.tfvars (gitignored) or TF\_VAR\_subscription\_id / ARM\_SUBSCRIPTION\_ID. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
