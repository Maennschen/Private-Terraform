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
| <a name="module_keyvault-dmn-tf-test"></a> [keyvault-dmn-tf-test](#module\_keyvault-dmn-tf-test) | ../../modules/key_vault | n/a |
| <a name="module_rg-services"></a> [rg-services](#module\_rg-services) | ../../modules/resource_group | n/a |
| <a name="module_sa00services"></a> [sa00services](#module\_sa00services) | ../../modules/storage_account | n/a |
| <a name="module_tst01-lvm"></a> [tst01-lvm](#module\_tst01-lvm) | ../../modules/vm_linux | n/a |
| <a name="module_vnet00-services"></a> [vnet00-services](#module\_vnet00-services) | ../../modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_management_lock.tfstate_container_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_admin_object_id"></a> [global\_admin\_object\_id](#input\_global\_admin\_object\_id) | n/a | `string` | `"44df9849-80f9-4366-8e10-bb698fe049aa"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | n/a | `string` | `"5d79c353-6bda-4509-8585-a88fb9d31a1b"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->