resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = azurerm_subnet.subnets
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = module.default_nsg.nsg_id
  depends_on                = [azurerm_subnet.subnets, module.default_nsg]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = module.default_nsg.nsg_id
}

module "default_nsg" {
  source              = "../network_security_group"
  nsg_name            = "default-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    Environment = "Dev"
    Purpose     = "Learning"
  }
  security_rules = {
    "allow_all_outbound" = {
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
