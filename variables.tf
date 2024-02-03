variable "environment" {

}

variable "resource_group_name" {
  default = "rg-spoke-demo"
}

variable "resource_group_location" {
  default = "francecentral"
}

variable "virtual_network_name" {
  default = "vnet-logicapp-demo"
}

variable "virtual_network_address_space" {
  default = "10.0.0.0/16"
}

variable "inbound_subnet_name" {
  default = "inboundSubnet"
}

variable "inbound_subnet_address_space" {
  default = "10.0.0.0/24"
}
variable "outbound_subnet_name" {
  default = "outboundSubnet"
}

variable "outbound_subnet_address_space" {
  default = "10.0.1.0/24"
}

variable "service_plan_name" {
  default = "logicappdatasync-asp"
}
variable "service_plan_zone_balancing_enabled" {
  default = true
}
variable "windows_logic_app_name" {
  default = "logicappdatalogc"
}

variable "storage_account_name" {
  default = "logicappdatasyncst"
}

variable "storage_account_replication_type" {
  default = "ZRS"
}

variable "storage_account_tier" {
  default = "Standard"
}

variable "storage_account_allowed_ip" {
  default = "90.26.62.205"
}

variable "log_analytics_workspace_name" {

}
variable "log_analytics_workspace_sku" {

}

variable "application_insights_name" {

}