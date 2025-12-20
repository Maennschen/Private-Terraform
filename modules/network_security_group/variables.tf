variable "nsg_name" {
  description = "Name der Network Security Group"
  type        = string
}

variable "location" {
  description = "Azure Region, in der die NSG erstellt wird"
  type        = string
}

variable "resource_group_name" {
  description = "Name der Resource Group"
  type        = string
}

variable "tags" {
  description = "Tags für die NSG"
  type        = map(string)
  default     = {}
}

variable "security_rules" {
  description = "Liste der Sicherheitsregeln für die NSG"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}
