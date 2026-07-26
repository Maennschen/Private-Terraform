resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}

# NSG is attached via azurerm_subnet_network_security_group_association below.
# Checkov graph often fails CKV2_AZURE_31 on module/for_each layouts despite the association existing.
resource "azurerm_subnet" "subnets" {
  # checkov:skip=CKV2_AZURE_31: NSG association resource exists on each subnet (azurerm_subnet_network_security_group_association); Checkov graph false positive with for_each modules
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
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

resource "azurerm_network_watcher_flow_log" "vnet" {
  count = var.enable_flow_logs ? 1 : 0

  network_watcher_name = data.azurerm_network_watcher.this[0].name
  resource_group_name  = data.azurerm_network_watcher.this[0].resource_group_name
  name                 = "${var.vnet_name}-flow-log"

  target_resource_id = azurerm_virtual_network.vnet.id
  storage_account_id = var.flow_log_storage_account_id
  enabled            = true
  version            = 2

  retention_policy {
    enabled = true
    days    = var.flow_log_retention_days
  }

  # Traffic Analytics / Log Analytics intentionally omitted (cost).
}
