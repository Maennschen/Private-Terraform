module "rg-compute" {
  source = "../modules/resource_group"

  name     = "rg-compute"
  location = "West Europe"
}

# Lab VM (Debian, B1s, SSH-only) — left in config for plan/wiring tests.
# Secrets expected in keyvault-dmn-tf-test:
#   - vm-admin-password
#   - vm-ssh-public-key
# NIC has no public IP — only private access inside the VNet.
# Do not apply casually (compute cost); deallocate when idle if applied.

# module "lvm01-tst" {
#   source = "../modules/vm_linux"

#   vmname              = "lvm01-tst"
#   resource_group_name = module.rg-compute.name
#   location            = module.rg-compute.location

#   subnet_id = module.vnet00-services.subnet_ids["v00s02vms"]
# }
