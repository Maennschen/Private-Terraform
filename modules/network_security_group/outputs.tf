output "nsg_id" {
  description = "ID der erstellten Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}
