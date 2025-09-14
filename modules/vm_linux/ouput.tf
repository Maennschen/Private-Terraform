output "vmname" {
  value = azurerm_linux_virtual_machine.linux_vm.name
}

output "nicname" {
  value = azurerm_network_interface.vm_nic.name
}