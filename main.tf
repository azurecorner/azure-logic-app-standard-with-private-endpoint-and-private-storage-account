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

resource "azurerm_storage_account" "storage_account" {
  account_replication_type        = "LRS"
  account_tier                    = "Standard"
  location                        = "francecentral"
  name                            = "logicappdatasyncst"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = ["90.26.62.205"]
    virtual_network_subnet_ids = [azurerm_subnet.outbound_subnet.id]
  }

  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_storage_share" "storage_share" {
  quota                = 5120
  name                 = "${var.windows_logic_app_name}-content"
  storage_account_name = azurerm_storage_account.storage_account.name

  depends_on = [azurerm_storage_account.storage_account]
}

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
