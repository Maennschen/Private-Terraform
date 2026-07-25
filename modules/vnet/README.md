<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_default_nsg"></a> [default\_nsg](#module\_default\_nsg) | ../network_security_group | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_network_watcher_flow_log.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_network_watcher.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/network_watcher) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | When true, create VNet flow logs via Network Watcher (needs flow\_log\_storage\_account\_id; incurs storage cost). Default off for free lab. | `bool` | `false` | no |
| <a name="input_flow_log_retention_days"></a> [flow\_log\_retention\_days](#input\_flow\_log\_retention\_days) | Retention days for VNet flow logs when enabled. | `number` | `7` | no |
| <a name="input_flow_log_storage_account_id"></a> [flow\_log\_storage\_account\_id](#input\_flow\_log\_storage\_account\_id) | Storage account ID for flow log retention. Required when enable\_flow\_logs is true. | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Datacenter Standort für das Virtuelle Netzwerk | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Ressourcen Gruppe für Virtual Network | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Liste der Subnetze mit Namen und Adressräumen | <pre>map(object({<br/>    address_prefixes = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Adressraum des VNet (z. B. ['10.0.0.0/16']) | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name für das Virtuelle Netzwerk | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map der Subnetz-IDs (Key = Subnetzname) |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID des Virtual Networks |
<!-- END_TF_DOCS -->
