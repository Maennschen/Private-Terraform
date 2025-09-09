provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-services"
    storage_account_name = "sa00services"
    container_name       = "sc00terraform"
    key                  = "terraform.tfstate"
  }
}