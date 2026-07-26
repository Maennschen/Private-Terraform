locals {
  # Wenn compliance_mode = true, aktiviere strenge Security-Features.
  # Logging bleibt absichtlich aus — auch im compliance_mode (Free-Lab: keine Log-Kosten per Default).
  security_config = var.compliance_mode ? {
    enable_public_network_access = false
    enable_network_restrictions  = true
    enable_private_endpoints     = true
    enable_cmk_encryption        = true
    enable_shared_access_key     = false
    enable_blob_diagnostic_logs  = false
  } : var.security_features
}
