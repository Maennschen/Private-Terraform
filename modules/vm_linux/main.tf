resource "azurerm_linux_virtual_machine" "linux_vm" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name          = var.vmname
  computer_name = var.vmname
  size          = "Standard_B1s"

  network_interface_ids = [ resource.azurerm_network_interface.vm_nic.id ]
  
  admin_username                  = "vm-admin"
  admin_password                  = data.azurerm_key_vault_secret.vm_password.value
  disable_password_authentication = false

  patch_assessment_mode = "AutomaticByPlatform"
  patch_mode            = "AutomaticByPlatform"

  allow_extension_operations = true
  provision_vm_agent         = true
  
  termination_notification {
    enabled = true
    timeout = "PT10M"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-13"
    sku       = "13"
    version   = "latest"
  }
  
  disk_controller_type = "SCSI"
  os_disk {
    name                 = "${var.vmname}-osdisk"
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

  accelerated_networking_enabled = false
  ip_forwarding_enabled          = false
  internal_dns_name_label        = var.vmname
  
  dns_servers = ["8.8.8.8", "9.9.9.9"]
  ip_configuration {
    name                          = "${var.vmname}-nic-config"
    primary                       = true
    subnet_id                     = var.vnet
    private_ip_address_version    = "IPv4"
    private_ip_address_allocation = "Dynamic"
  }
}