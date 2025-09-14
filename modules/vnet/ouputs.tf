output "vnet_id" {
  description = "ID des Virtual Networks"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  description = "Map der Subnetz-IDs (Key = Subnetzname)"
  value       = { for name, subnet in azurerm_subnet.subnets : name => subnet.id }
}
