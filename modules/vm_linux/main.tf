resource "azurerm_linux_virtual_machine" "linux_vm" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name = var.vmname
  size = "Standard_B1ls"

  network_interface_ids = [ resource.azurerm_network_interface.vm_nic.id ]
  
  admin_username = "vm-admin"
  admin_password = data.azurerm_key_vault_secret.vm_password.value

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-noble"
    sku       = "24_04-lts-gen2"
    version   = "latest"
  }
  
  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "None"
    disk_size_gb         = 47
  }

  lifecycle {
    ignore_changes = [ admin_password ]
  }
}

resource "azurerm_network_interface" "vm_nic" {
  resource_group_name = var.resource_group_name
  location            = var.location
  
  name = "${var.vmname}-nic"
  
  ip_configuration {
    name                          = "${var.vmname}-nic-config"
    subnet_id                     = var.vnet
    private_ip_address_allocation = "Dynamic"
  }
}