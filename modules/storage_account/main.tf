resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_blob_public_access
  shared_access_key_enabled       = var.shared_access_key_enabled
  min_tls_version                 = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  sas_policy {
    expiration_period = "90.00:00:00"
  }

  tags = var.tags
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
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
