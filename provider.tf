# terraform {
#   backend "azurerm" {
#     resource_group_name  = "rg-services"
#     storage_account_name = "sa00services"
#     container_name       = "sc00terraform"
#     key                  = "terraform.tfstate"
#   }
# }

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  # client_id       = var.client_id
  # tenant_id       = var.tenant_id

  # client_certificate_path     = var.client_certificate_path
  # client_certificate_password = var.client_certificate_password
}
