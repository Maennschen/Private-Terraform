module "rg-network" {
  source = "../../modules/resource_group"

  name     = "rg-network"
  location = "West Europe"
}

module "vnet00-services" {
  source = "../../modules/vnet"

  resource_group_name = module.rg-network.name
  location            = module.rg-network.location
  vnet_name           = "vnet00-services"
  vnet_address_space  = ["10.0.0.0/16"]

  subnets = {
    "v00s01services" = {
      address_prefixes = ["10.0.1.0/24"]
    },
    "v00s02vms" = {
      address_prefixes = ["10.0.2.0/24"]
    }
  }

  # Implemented, default off — wire storage id from subscription when enabling
  enable_flow_logs            = var.enable_vnet_flow_logs
  flow_log_storage_account_id = var.flow_log_storage_account_id
}
