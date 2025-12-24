module "services" {
  source = "./rg-services"
}

module "network" {
  source = "./rg-network"
}

module "compute" {
  source = "./rg-compute"
}
