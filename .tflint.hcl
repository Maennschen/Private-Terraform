config {
    call_module_type = "local"
    force = false
}

plugin "azurerm" {
    enabled = true
    version = "0.29.0"
    source = "github.com/terraform-linters/tflint-ruleset-azurerm"
}