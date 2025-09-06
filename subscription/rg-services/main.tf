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

  storage_containers = {
    sc00terraform = {
      container_name = "sc00terraform"
      container_access_type = "private"
      role_assignments = {
        rule1 = {
          role_definition_name = "Storage Blob Terraform State"
          principal_id         = var.global_admin_object_id
        }
      }
    } 
  }

  file_shares = {
    #fs00servicestore = {
      fileshare_name = "fs00servicestore"
      quota                 = 5
      # role_assignments = {
      #   rule1 = {
      #     role_definition_name = "Storage File Data SMB Share Contributor"
      #     principal_id         = var.global_admin_object_id
      #   }
      # }
    #}
  }
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
