resource "azurerm_resource_group" "resource_group" {
  location = "francecentral"
  name     = var.resource_group_name
}

resource "azurerm_virtual_network" "virtual_network" {
  address_space       = ["10.0.0.0/16"]
  location            = "francecentral"
  name                = "vnet-logicapp-demo"
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_subnet" "inbound_subnet" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "inboundSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}
resource "azurerm_subnet" "outbound_subnet" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "outboundSubnet"
  resource_group_name  = var.resource_group_name
  service_endpoints    = ["Microsoft.Storage"]
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  delegation {
    name = "delegation"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      name    = "Microsoft.Web/serverFarms"
    }
  }
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}


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
