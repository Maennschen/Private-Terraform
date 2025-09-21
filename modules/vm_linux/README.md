<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.vm_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.vm_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Datacenterlocation der VM | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name der zugehörigen Resourcen Gruppe | `string` | n/a | yes |
| <a name="input_vmname"></a> [vmname](#input\_vmname) | Name der Virtuellen Maschine | `string` | n/a | yes |
| <a name="input_vnet"></a> [vnet](#input\_vnet) | Vnet für das Nic | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nicname"></a> [nicname](#output\_nicname) | n/a |
| <a name="output_vmname"></a> [vmname](#output\_vmname) | n/a |
<!-- END_TF_DOCS -->