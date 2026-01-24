<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default_nsg"></a> [default\_nsg](#module\_default\_nsg) | ../network_security_group | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.subnet_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | Datacenter Standort für das Virtuelle Netzwerk | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Ressourcen Gruppe für Virtual Network | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Liste der Subnetze mit Namen und Adressräumen | <pre>map(object({<br/>    address_prefixes = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_vnet_address_space"></a> [vnet\_address\_space](#input\_vnet\_address\_space) | Adressraum des VNet (z. B. ['10.0.0.0/16']) | `list(string)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name für das Virtuelle Netzwerk | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Map der Subnetz-IDs (Key = Subnetzname) |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | ID des Virtual Networks |
<!-- END_TF_DOCS -->
