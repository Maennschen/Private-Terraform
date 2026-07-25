module "services" {
  source = "./rg-services"
}

module "network" {
  source = "./rg-network"

  # Flow logs code path exists in the vnet module; left disabled (no log storage spend).
  # To enable later:
  #   enable_vnet_flow_logs      = true
  #   flow_log_storage_account_id = module.services.storage_account_id
  enable_vnet_flow_logs       = false
  flow_log_storage_account_id = null
}

module "compute" {
  source = "./rg-compute"
}
