output "storage_account_id" {
  description = "ID des erstellten Storage Accounts."
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name des erstellten Storage Accounts."
  value       = azurerm_storage_account.this.name
}

output "file_share_names" {
  description = "Namen der erstellten File Shares."
  value       = [for share in azurerm_storage_share.this : share.name]
}

output "storage_container_names" {
  description = "Namen der erstellten Storage Container."
  value       = [for container in azurerm_storage_container.this : container.name]
}

output "storage_container_ids" {
  description = "IDs der erstellten Storage Container."
  value       = [for container in azurerm_storage_container.this : container.id]
}