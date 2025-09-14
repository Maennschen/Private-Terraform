variable "resource_group_name" {
  description = "Name der zugehörigen Resourcen Gruppe"
  type = string
}

variable "location" {
  description = "Datacenterlocation der VM"
  type = string
}

variable "vmname" {
  description = "Name der Virtuellen Maschine"
  type = string
}

variable "vnet" {
  description = "Vnet für das Nic"
  type = string  
}