environment                         = "prod"
resource_group_name                 = "rg-spoke-demo-prod"
resource_group_location             = "francecentral"
virtual_network_name                = "vnet-logicapp-demo"
virtual_network_address_space       = "10.1.0.0/16"
inbound_subnet_name                 = "inboundSubnet"
inbound_subnet_address_space        = "10.1.0.0/24"
outbound_subnet_name                = "outboundSubnet"
outbound_subnet_address_space       = "10.1.1.0/24"
service_plan_name                   = "logicappdatasync-asp"
service_plan_zone_balancing_enabled = true
windows_logic_app_name              = "logicappdatalogc"
storage_account_name                = "logicappdatasyncst"
storage_account_replication_type    = "ZRS"
storage_account_tier                = "Standard"
storage_account_allowed_ip          = "90.26.62.205"
log_analytics_workspace_name        = "la-datasync"
log_analytics_workspace_sku         = "PerGB2018"
application_insights_name           = "app-insight-datasync"
  