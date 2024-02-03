
resource "azurerm_private_dns_zone" "azurewebsites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_private_dns_zone" "web_core_windows" {
  name                = "privatelink.web.core.windows.net"
  resource_group_name = var.resource_group_name

   depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link_azurewebsites" {
  name                  = "logicappdatasync-link"
  private_dns_zone_name = azurerm_private_dns_zone.azurewebsites.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
  depends_on = [
    azurerm_private_dns_zone.azurewebsites,
    azurerm_virtual_network.virtual_network
  ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link_windows_web_core" {
  name                  = "logicappdatasync-link-blob"
  private_dns_zone_name = azurerm_private_dns_zone.web_core_windows.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.virtual_network.id
  depends_on = [
    azurerm_private_dns_zone.web_core_windows,
    azurerm_virtual_network.virtual_network
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

locals {
  storage_subresources = ["blob", "file", "queue", "table"]
}

resource "azurerm_private_endpoint" "private_endpoint_storage" {
   for_each                                    = toset(local.storage_subresources)
  location            = var.resource_group_location
  name                = "pe-${var.windows_logic_app_name}-${each.key}"
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.inbound_subnet.id
  private_service_connection {
    is_manual_connection           = false
    name                           = "pe-con-${var.windows_logic_app_name}-${each.key}"
    private_connection_resource_id = azurerm_logic_app_standard.logic_app_standard.id
    subresource_names              = [each.key]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.web_core_windows.id]
  }
  depends_on = [azurerm_private_dns_zone.web_core_windows,azurerm_storage_account.storage_account, azurerm_private_dns_zone_virtual_network_link.virtual_network_link_azurewebsites]
}