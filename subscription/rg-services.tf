# Free-lab baseline:
# - public network on SA/KV (dynamic home IP, no PE)
# - shared keys off → Entra ID + RBAC data plane
# - no blob diagnostic logs by default (log storage cost)
# - no KV network ACLs (module default false)
# tenant_id comes from the signed-in identity (not committed); object ID via tfvars.

data "azurerm_client_config" "current" {}

module "rg-services" {
  source = "../modules/resource_group"

  name     = "rg-services"
  location = "West Europe"
}

module "sa00services" {
  source = "../modules/storage_account"

  storage_account_name     = "sa00services"
  resource_group_name      = module.rg-services.name
  location                 = module.rg-services.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  file_shares = [
    {
      name        = "fs00services"
      quota       = 5
      access_tier = "Hot"
    }
  ]

  allow_blob_public_access  = false
  shared_access_key_enabled = false
  data_plane_principal_id   = var.global_admin_object_id
}

module "keyvault-dmn-tf-test" {
  source = "../modules/key_vault"

  key_vault_name      = "keyvault-dmn-tf-test"
  resource_group_name = module.rg-services.name
  location            = module.rg-services.location

  tenant_id              = data.azurerm_client_config.current.tenant_id
  sku_name               = "standard"
  global_admin_object_id = var.global_admin_object_id
}
