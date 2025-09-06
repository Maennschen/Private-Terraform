resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name
  storage_account_id    = resource.azurerm_storage_account.storage_account.id
  container_access_type = var.container_access_type
}

# resource "azurerm_role_assignment" "container_contributor" {
#   for_each = merge([
#     for container_name, container_config in var.storage_containers : {
#       for role_name, role_config in container_config.role_assignments : "${container_name}-${role_name}" => {
#         scope                = "${azurerm_storage_account.storage_account[container_config.storage_account_name].id}/blobServices/default/containers/${container_name}"
#         role_definition_name = role_config.role_definition_name
#         principal_id         = role_config.principal_id
#       }
#     }
#   ]...)

#   scope                = each.value.scope
#   role_definition_name = each.value.role_definition_name
#   principal_id         = each.value.principal_id
# }

resource "azurerm_storage_share" "file_share" {
  name                 = var.fileshare_name
  storage_account_id   = resource.azurerm_storage_account.storage_account.id
  quota                = var.quota
}

# resource "azurerm_role_assignment" "fileshare_contributor" {
#   for_each = merge([
#     for share_name, share_config in var.file_shares : {
#       for role_name, role_config in share_config.role_assignments : "${share_name}-${role_name}" => {
#         scope                = azurerm_storage_share.file_share[share_name].id
#         role_definition_name = role_config.role_definition_name
#         principal_id         = role_config.principal_id
#       }
#     }
#   ]...)

#   scope                = each.value.scope
#   role_definition_name = each.value.role_definition_name
#   principal_id         = each.value.principal_id
# }
