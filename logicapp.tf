
resource "azurerm_service_plan" "service_plan" {
  location            = "francecentral"
  name                = "logicappdatasync-asp"
  os_type             = "Windows"
  resource_group_name = var.resource_group_name
  sku_name            = "WS1"
  #zone_balancing_enabled = true
  depends_on = [
    azurerm_resource_group.resource_group
  ]
}
resource "azurerm_logic_app_standard" "logic_app_standard" {
  app_service_plan_id        = azurerm_service_plan.service_plan.id
  https_only                 = true
  location                   = "francecentral"
  name                       = var.windows_logic_app_name
  resource_group_name        = var.resource_group_name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  storage_account_name       = azurerm_storage_account.storage_account.name

  version                   = "~4"
  virtual_network_subnet_id = azurerm_subnet.outbound_subnet.id
  identity {
    type = "SystemAssigned"
  }


  app_settings = {
    "WEBSITE_CONTENTOVERVNET" : "1"
    "FUNCTIONS_WORKER_RUNTIME" : "node"
    "WEBSITE_NODE_DEFAULT_VERSION" : "~18"
    # "APPINSIGHTS_INSTRUMENTATIONKEY" = var.instrumentation_key
  }

  site_config {
    use_32_bit_worker_process        = false
    ftps_state                       = "Disabled"
    websockets_enabled               = false
    min_tls_version                  = "1.2"
    runtime_scale_monitoring_enabled = false
    vnet_route_all_enabled           = true
    always_on                        = true
    public_network_access_enabled    = false
  }
  depends_on = [
    azurerm_subnet.outbound_subnet, azurerm_storage_share.storage_share,
    azurerm_service_plan.service_plan
  ]
}



resource "azurerm_private_endpoint" "private_endpoint" {
  location            = var.resource_group_location
  name                = "pe-${var.windows_logic_app_name}"
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.inbound_subnet.id
  private_service_connection {
    is_manual_connection           = false
    name                           = "pe-con-${var.windows_logic_app_name}"
    private_connection_resource_id = azurerm_logic_app_standard.logic_app_standard.id
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.azurewebsites.id]
  }
  depends_on = [azurerm_private_dns_zone.azurewebsites, azurerm_logic_app_standard.logic_app_standard, azurerm_private_dns_zone_virtual_network_link.virtual_network_link_azurewebsites]
}
