module "rg-compute" {
  source = "../../modules/resource_group"

  name     = "rg-compute"
  location = "West Europe"
}

# Optional lab VM (Debian, B1s, SSH-only) — currently disabled (cost + Key Vault secrets).
# Module modules/vm_linux expects secrets in keyvault-dmn-tf-test:
#   - vm-admin-password
#   - vm-ssh-public-key
# Wire via subnet_id (Subnet resource ID), not VNet ID — prefer module output over data source:
#   subnet_id = module.network.subnet_ids["v00s02vms"]   # after rg-network exposes outputs
# NIC has no public IP — only private access inside the VNet.

module "lvm01-tst" {
  source = "../../modules/vm_linux"

  vmname              = "lvm01-tst"
  resource_group_name = module.rg-compute.location
  location            = module.rg-compute.location

  subnet_id = module.network.subnet_ids["v00s02vms"]
}
