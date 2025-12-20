data "azurerm_key_vault" "keyvault" {
  name                = "keyvault-dmn-tf-test"
  resource_group_name = "rg-services"
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "vm_ssh_public_key" {
  name         = "vm-ssh-public-key"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
