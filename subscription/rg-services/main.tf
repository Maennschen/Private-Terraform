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

  storage_containers = [
    {
      name                  = "sc00terraform"
      container_access_type = "private"
    }
  ]
}

resource "azurerm_management_lock" "tfstate_container_lock" {
  name       = "TerraformStateProtection"
  scope      = module.sa00services.storage_container_ids[0]
  lock_level = "CanNotDelete"
  notes      = "Schützt den Terraform State-Container vor versehentlicher Löschung."
}

module "keyvault-dmn-tf-test" {
  source = "../../modules/key_vault"

  key_vault_name      = "keyvault-dmn-tf-test"
  resource_group_name = module.rg-services.name
  location            = module.rg-services.location

  tenant_id              = var.tenant_id
  sku_name               = "standard"
  global_admin_object_id = var.global_admin_object_id
}
