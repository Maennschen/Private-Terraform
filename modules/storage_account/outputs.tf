output "storage_account_id" {
  description = "ID des erstellten Storage Accounts."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "Name des erstellten Storage Accounts."
  value       = azurerm_storage_account.storage_account.name
}

output "file_share_names" {
  description = "Namen der erstellten File Shares."
  value       = { for name, share in azurerm_storage_share.file_share : name => share.name }
}

output "file_share_ids" {
  description = "IDs der erstellten File Shares."
  value       = { for name, share in azurerm_storage_share.file_share : name => share.id }
}

output "storage_container_names" {
  description = "Namen der erstellten Storage Container."
  value       = { for name, container in azurerm_storage_container.storage_container : name => container.name }
}

output "storage_container_ids" {
  description = "IDs der erstellten Storage Container."
  value       = { for name, container in azurerm_storage_container.storage_container : name => container.id }
}