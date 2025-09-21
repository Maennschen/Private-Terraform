variable "resource_group_name" {
  description = "Ressourcen Gruppe für Virtual Network"
  type        = string
}

variable "vnet_name" {
  description = "Name für das Virtuelle Netzwerk"
  type        = string
}

variable "location" {
  description = "Datacenter Standort für das Virtuelle Netzwerk"
  type        = string
}

variable "vnet_address_space" {
  description = "Adressraum des VNet (z. B. ['10.0.0.0/16'])"
  type        = list(string)
}

variable "subnets" {
  description = "Liste der Subnetze mit Namen und Adressräumen"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {}
}
