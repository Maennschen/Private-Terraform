# Free / learning lab — no private endpoint budget; public access needed with dynamic home IP.
resource "azurerm_key_vault" "key_vault" {
  # checkov:skip=CKV2_AZURE_32: Free learning lab — Key Vault private endpoint costs money; not in scope
  # checkov:skip=CKV_AZURE_189: Public network access kept for home access; DE residential IP is dynamic (no stable ip_rules without PE/VPN)
  name                        = var.key_vault_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name
  purge_protection_enabled    = true
  soft_delete_retention_days  = 90

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

  public_network_access_enabled = var.public_network_access_enabled

  # Feature Toggle: Network ACLs
  dynamic "network_acls" {
    for_each = var.network_acls_enabled ? [1] : []
    content {
      default_action = "Deny"
      bypass         = "AzureServices"
      ip_rules       = var.allowed_ip_ranges
    }
  }
}
