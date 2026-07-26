output "storage_account_id" {
  description = "ID of sa00services (e.g. for VNet flow log destination when enabled)."
  value       = module.sa00services.storage_account_id
}

output "storage_account_name" {
  description = "Name of sa00services."
  value       = module.sa00services.storage_account_name
}
