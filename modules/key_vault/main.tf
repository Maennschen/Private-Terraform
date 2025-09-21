resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name
  purge_protection_enabled    = true
  soft_delete_retention_days  = 90

  network_acls {
    default_action = "Deny"
    ip_rules       = [var.ip]
    bypass         = "AzureServices"
  }

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.global_admin_object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Restore", "Backup", "Update"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Restore", "Backup"
    ]

    certificate_permissions = [
      "Get", "List", "Update", "Create", "Import", "Delete", "Purge"
    ]
  }
}
