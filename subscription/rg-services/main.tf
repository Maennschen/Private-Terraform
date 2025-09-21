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
  scope      = module.sa00services.storage_container_ids.sc00terraform
  lock_level = "CanNotDelete"
  notes      = "Schützt den Terraform State-Container vor versehentlicher Löschung."
}

module "keyvault-dmn-tf-test" {
  source = "../../modules/key_vault"

  key_vault_name      = "keyvault-dmn-tf-test"
  resource_group_name = module.rg-services.name
  location            = module.rg-services.location

  ip = "194.126.177.146/32"

  tenant_id              = var.tenant_id
  sku_name               = "standard"
  global_admin_object_id = var.global_admin_object_id
}

module "vnet00-services" {
  source = "../../modules/vnet"

  resource_group_name = module.rg-services.name
  location            = module.rg-services.location
  vnet_name           = "vnet00-services"
  vnet_address_space  = ["10.0.0.0/16"]

  subnets = {
    "subnet1" = {
      address_prefixes = ["10.0.1.0/24"]
    },
    "subnet2" = {
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}

module "tst01-lvm" {
  source = "../../modules/vm_linux"

  vmname              = "tst01-lvm"
  resource_group_name = module.rg-services.name
  location            = module.rg-services.location

  vnet = module.vnet00-services.subnet_ids.subnet1
}
