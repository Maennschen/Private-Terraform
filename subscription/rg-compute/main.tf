module "rg-compute" {
  source = "../../modules/resource_group"

  name     = "rg-compute"
  location = "West Europe"
}

# module "tst01-lvm" {
#   source = "../../modules/vm_linux"

#   vmname              = "tst01-lvm"
#   resource_group_name = module.rg-services.name
#   location            = module.rg-services.location

#   vnet = module.vnet00-services.subnet_ids.v00s02vms
# }
