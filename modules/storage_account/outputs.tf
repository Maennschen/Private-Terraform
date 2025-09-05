output "storage_account_id" {
  value = azurerm_storage_account.storage_account[0].id
}

output "storage_container_id" {
  value = var.create_storage_container ? azurerm_storage_container.storage_container[0].id : null
}

output "fileshare_id" {
  value = var.create_file_share ? azurerm_storage_share.file_share[0].id : null
}