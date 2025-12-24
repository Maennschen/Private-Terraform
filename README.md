<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.14.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subscription"></a> [subscription](#module\_subscription) | ./subscription | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compliance_mode"></a> [compliance\_mode](#input\_compliance\_mode) | Shortcut: Set to true for Checkov scan, false for daily operations | `bool` | `false` | no |
| <a name="input_security_features"></a> [security\_features](#input\_security\_features) | Toggle security features for Checkov compliance vs operational access | <pre>object({<br/>    enable_public_network_access = bool # true = Zugriff möglich, false = Checkov compliant<br/>    enable_network_restrictions  = bool # true = Firewall-Regeln aktiv<br/>    enable_private_endpoints     = bool # true = Private Endpoints (kostet Geld!)<br/>    enable_cmk_encryption        = bool # true = Customer Managed Keys<br/>  })</pre> | <pre>{<br/>  "enable_cmk_encryption": false,<br/>  "enable_network_restrictions": false,<br/>  "enable_private_endpoints": false,<br/>  "enable_public_network_access": true<br/>}</pre> | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | n/a | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
