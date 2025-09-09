resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}

resource "azurerm_storage_share" "this" {
  for_each = {
    for share in var.file_shares : share.name => share
  }

  name               = each.value.name
  storage_account_id = azurerm_storage_account.this.id
  quota              = each.value.quota
  access_tier        = each.value.access_tier
}

resource "azurerm_storage_container" "this" {
  for_each = {
    for container in var.storage_containers : container.name => container
  }

  name                  = each.value.name
  storage_account_id   = azurerm_storage_account.this.id
  container_access_type = each.value.container_access_type
}
