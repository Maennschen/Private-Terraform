module "rg-services" {
  source = "../../modules/resource_group"

  name     = "rg-services"
  location = "West Europe"
}

module "sa00services" {
  source = "../../modules/storage_account"

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

  public_network_access_enabled = local.security_config.enable_public_network_access
  allow_blob_public_access      = false
  # Decoupled from CMK: keys off by default (Entra + RBAC). Not the Terraform state account.
  shared_access_key_enabled = local.security_config.enable_shared_access_key
  data_plane_principal_id   = var.global_admin_object_id
}

module "keyvault-dmn-tf-test" {
  source = "../../modules/key_vault"

  key_vault_name      = "keyvault-dmn-tf-test"
  resource_group_name = module.rg-services.name
  location            = module.rg-services.location

  tenant_id              = var.tenant_id
  sku_name               = "standard"
  global_admin_object_id = var.global_admin_object_id

  public_network_access_enabled = local.security_config.enable_public_network_access
  network_acls_enabled          = local.security_config.enable_network_restrictions
}
