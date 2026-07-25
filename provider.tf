terraform {
  required_version = "1.15.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sa00tfstateservices"
    container_name       = "sc00terraform"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  # Required when shared_access_key_enabled = false — data plane (queues, shares, blobs) via Entra ID
  storage_use_azuread = true
}
