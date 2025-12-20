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
    "allow_all_inbound" = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound_rdp" = {
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound_ssh" = {
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound_ms_sql" = {
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound-oracle_db" = {
      priority                   = 104
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "1521"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound_mysql" = {
      priority                   = 105
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "3306"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    "deny_cummon_inbound_postgres_db" = {
      priority                   = 106
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "5432"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
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
