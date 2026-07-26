module "rg-network" {
  source = "../modules/resource_group"

  name     = "rg-network"
  location = "West Europe"
}

module "vnet00-services" {
  source = "../modules/vnet"

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

  # Flow logs path exists in the vnet module; left disabled (no log storage spend).
  # To enable later:
  #   enable_flow_logs            = true
  #   flow_log_storage_account_id = module.sa00services.storage_account_id
  enable_flow_logs            = false
  flow_log_storage_account_id = null
}
