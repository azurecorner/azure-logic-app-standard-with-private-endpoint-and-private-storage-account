resource "azurerm_resource_group" "resource_group" {
  location = "francecentral"
  name     = "rg-spoke-demo"
}
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_private_dns_a_record" "res-2" {
  name                = "logicappdatasync"
  records             = ["10.0.0.4"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasync with resource guid 33168950-157a-4b4e-a1ef-c37b29262ecc"
  }
  ttl       = 10
  zone_name = "privatelink.azurewebsites.net"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone,
  ]
}
resource "azurerm_private_dns_a_record" "res-3" {
  name                = "logicappdatasync.scm"
  records             = ["10.0.0.4"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasync with resource guid 33168950-157a-4b4e-a1ef-c37b29262ecc"
  }
  ttl       = 10
  zone_name = "privatelink.azurewebsites.net"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-5" {
  name                  = "logicappdatasync-link"
  private_dns_zone_name = "privatelink.azurewebsites.net"
  resource_group_name   = "rg-spoke-demo"
  virtual_network_id    = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone,
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_private_dns_zone" "res-6" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_private_dns_a_record" "res-7" {
  name                = "logicappdatasyncst"
  records             = ["10.0.2.6"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasyncst-logicappdatasyncst-blob-private-endpoint with resource guid 165bd0dc-13e3-4ef5-936a-e884f030798a"
  }
  ttl       = 10
  zone_name = "privatelink.blob.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.res-6,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-9" {
  name                  = "privatelink.blob.core.windows.net-link"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  resource_group_name   = "rg-spoke-demo"
  virtual_network_id    = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound"
  depends_on = [
    azurerm_private_dns_zone.res-6,
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_private_dns_zone" "private_dns_zone0" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_private_dns_a_record" "private_dns_zone1" {
  name                = "logicappdatasyncst"
  records             = ["10.0.2.7"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasyncst-logicappdatasyncst-file-private-endpoint with resource guid 8d63cc98-ecd2-487d-8d2c-a136a31caeee"
  }
  ttl       = 10
  zone_name = "privatelink.file.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone0,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone3" {
  name                  = "privatelink.file.core.windows.net-link"
  private_dns_zone_name = "privatelink.file.core.windows.net"
  resource_group_name   = "rg-spoke-demo"
  virtual_network_id    = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone0,
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_private_dns_zone" "private_dns_zone4" {
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_private_dns_a_record" "private_dns_zone5" {
  name                = "logicappdatasyncst"
  records             = ["10.0.2.5"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasyncst-logicappdatasyncst-queue-private-endpoint with resource guid 1c22a858-ce8b-4fff-87b1-e85441cdbb44"
  }
  ttl       = 10
  zone_name = "privatelink.queue.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone4,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone7" {
  name                  = "privatelink.queue.core.windows.net-link"
  private_dns_zone_name = "privatelink.queue.core.windows.net"
  resource_group_name   = "rg-spoke-demo"
  virtual_network_id    = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone4,
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_private_dns_zone" "private_dns_zone8" {
  name                = "privatelink.table.core.windows.net"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_private_dns_a_record" "private_dns_zone9" {
  name                = "logicappdatasyncst"
  records             = ["10.0.2.4"]
  resource_group_name = "rg-spoke-demo"
  tags = {
    creator = "created by private endpoint pe-logicappdatasyncst-logicappdatasyncst-table-private-endpoint with resource guid cbf140fc-868b-438b-bcf0-cf71397bad5c"
  }
  ttl       = 10
  zone_name = "privatelink.table.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone8,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-21" {
  name                  = "privatelink.table.core.windows.net-link"
  private_dns_zone_name = "privatelink.table.core.windows.net"
  resource_group_name   = "rg-spoke-demo"
  virtual_network_id    = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound"
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone8,
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_private_endpoint" "res-22" {
  location            = "francecentral"
  name                = "pe-logicappdatasync"
  resource_group_name = "rg-spoke-demo"
  subnet_id           = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/inboundSubnet"
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "pe-logicappdatasync"
    private_connection_resource_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Web/Sites/logicappdatasync"
    subresource_names              = ["sites"]
  }
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone,
    azurerm_subnet.res-33,
  ]
}
resource "azurerm_private_endpoint" "res-24" {
  location            = "francecentral"
  name                = "pe-logicappdatasyncst-logicappdatasyncst-blob-private-endpoint"
  resource_group_name = "rg-spoke-demo"
  subnet_id           = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/storageSubnetInbound"
  private_dns_zone_group {
    name                 = "logicappdatasyncst-blob-private-endpoint"
    private_dns_zone_ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "blobPrivateLinkConnection"
    private_connection_resource_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Storage/storageAccounts/logicappdatasyncst"
    subresource_names              = ["blob"]
  }
  depends_on = [
    azurerm_private_dns_zone.res-6,
    azurerm_subnet.res-35,
    azurerm_storage_account.res-36,
  ]
}
resource "azurerm_private_endpoint" "res-26" {
  location            = "francecentral"
  name                = "pe-logicappdatasyncst-logicappdatasyncst-file-private-endpoint"
  resource_group_name = "rg-spoke-demo"
  subnet_id           = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/storageSubnetInbound"
  private_dns_zone_group {
    name                 = "logicappdatasyncst-file-private-endpoint"
    private_dns_zone_ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "filePrivateLinkConnection"
    private_connection_resource_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Storage/storageAccounts/logicappdatasyncst"
    subresource_names              = ["file"]
  }
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone0,
    azurerm_subnet.res-35,
    azurerm_storage_account.res-36,
  ]
}
resource "azurerm_private_endpoint" "res-28" {
  location            = "francecentral"
  name                = "pe-logicappdatasyncst-logicappdatasyncst-queue-private-endpoint"
  resource_group_name = "rg-spoke-demo"
  subnet_id           = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/storageSubnetInbound"
  private_dns_zone_group {
    name                 = "logicappdatasyncst-queue-private-endpoint"
    private_dns_zone_ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/privateDnsZones/privatelink.queue.core.windows.net"]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "queuePrivateLinkConnection"
    private_connection_resource_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Storage/storageAccounts/logicappdatasyncst"
    subresource_names              = ["queue"]
  }
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone4,
    azurerm_subnet.res-35,
    azurerm_storage_account.res-36,
  ]
}
resource "azurerm_private_endpoint" "res-30" {
  location            = "francecentral"
  name                = "pe-logicappdatasyncst-logicappdatasyncst-table-private-endpoint"
  resource_group_name = "rg-spoke-demo"
  subnet_id           = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/storageSubnetInbound"
  private_dns_zone_group {
    name                 = "logicappdatasyncst-table-private-endpoint"
    private_dns_zone_ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/privateDnsZones/privatelink.table.core.windows.net"]
  }
  private_service_connection {
    is_manual_connection           = false
    name                           = "tablePrivateLinkConnection"
    private_connection_resource_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Storage/storageAccounts/logicappdatasyncst"
    subresource_names              = ["table"]
  }
  depends_on = [
    azurerm_private_dns_zone.private_dns_zone8,
    azurerm_subnet.res-35,
    azurerm_storage_account.res-36,
  ]
}
resource "azurerm_virtual_network" "res-32" {
  address_space       = ["10.0.0.0/16"]
  location            = "francecentral"
  name                = "vnet-logicappOutbound"
  resource_group_name = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_subnet" "res-33" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "inboundSubnet"
  resource_group_name  = "rg-spoke-demo"
  virtual_network_name = "vnet-logicappOutbound"
  depends_on = [
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_subnet" "res-34" {
  address_prefixes     = ["10.0.1.0/24"]
  name                 = "outboundSubnet"
  resource_group_name  = "rg-spoke-demo"
  service_endpoints    = ["Microsoft.Storage"]
  virtual_network_name = "vnet-logicappOutbound"
  delegation {
    name = "delegation"
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      name    = "Microsoft.Web/serverFarms"
    }
  }
  depends_on = [
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_subnet" "res-35" {
  address_prefixes     = ["10.0.2.0/24"]
  name                 = "storageSubnetInbound"
  resource_group_name  = "rg-spoke-demo"
  virtual_network_name = "vnet-logicappOutbound"
  depends_on = [
    azurerm_virtual_network.res-32,
  ]
}
resource "azurerm_storage_account" "res-36" {
  account_replication_type         = "ZRS"
  account_tier                     = "Standard"
  # allow_nested_items_to_be_public  = false
  # cross_tenant_replication_enabled = false
  # default_to_oauth_authentication  = true
  location                         = "francecentral"
  name                             = "logicappdatasyncst"
  resource_group_name              = "rg-spoke-demo"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
# resource "azurerm_storage_container" "res-38" {
#   name                 = "azure-webjobs-hosts"
#   storage_account_name = "logicappdatasyncst"
# }
# resource "azurerm_storage_container" "res-39" {
#   name                 = "azure-webjobs-secrets"
#   storage_account_name = "logicappdatasyncst"
# }
resource "azurerm_storage_share" "res-41" {
  name                 = "logicappdatasync922f"
  quota                = 5120
  storage_account_name = "logicappdatasyncst"
}
# resource "azurerm_storage_queue" "res-47" {
#   name                 = "flow17329c59e4e56b1jobtriggers00"
#   storage_account_name = "logicappdatasyncst"
# }
# resource "azurerm_storage_table" "res-49" {
#   name                 = "flow17329c59e4e56b1flowsubscriptions"
#   storage_account_name = "logicappdatasyncst"
# }
# resource "azurerm_storage_table" "res-50" {
#   name                 = "flow17329c59e4e56b1jobdefinitions"
#   storage_account_name = "logicappdatasyncst"
# }
# resource "azurerm_storage_table" "res-51" {
#   name                 = "flow17329c59e4e56b1workeraffinitylistenercertificates"
#   storage_account_name = "logicappdatasyncst"
# }
resource "azurerm_service_plan" "res-52" {
  location               = "francecentral"
  name                   = "logicappdatasync-asp"
  os_type                = "Windows"
  resource_group_name    = "rg-spoke-demo"
  sku_name               = "WS1"
  zone_balancing_enabled = true
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
resource "azurerm_logic_app_standard" "res-53" {
  app_service_plan_id        = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Web/serverfarms/logicappdatasync-asp"
  https_only                 = true
  location                   = "francecentral"
  name                       = "logicappdatasync"
  resource_group_name        = "rg-spoke-demo"
  storage_account_access_key = "8L2w2O/rtkukeoOR0BAZ36I+18r7Cq/0qw4H8n97eZcsxLBtLQCRk6tBZYiK4Ph64i9da7vCk1j4+ASt1PLKnA=="
  storage_account_name       = "logicappdatasyncst"
  tags = {
    "hidden-link: /app-insights-resource-id" = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Insights/components/logicappdatasyncinsight"
  }
  version                   = "~4"
  virtual_network_subnet_id = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/rg-spoke-demo/providers/Microsoft.Network/virtualNetworks/vnet-logicappOutbound/subnets/outboundSubnet"
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_subnet.res-34,
    azurerm_service_plan.res-52,
    azurerm_application_insights.res-61,
  ]
}
# resource "azurerm_app_service_custom_hostname_binding" "res-57" {
#   app_service_name    = "logicappdatasync"
#   hostname            = "logicappdatasync.azurewebsites.net"
#   resource_group_name = "rg-spoke-demo"
#   depends_on = [
#     azurerm_logic_app_standard.res-53,
#   ]
# }
# resource "azurerm_monitor_smart_detector_alert_rule" "res-59" {
#   description         = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
#   detector_type       = "FailureAnomaliesDetector"
#   frequency           = "PT1M"
#   name                = "Failure Anomalies - logicappdatasyncinsight"
#   resource_group_name = "rg-spoke-demo"
#   scope_resource_ids  = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourcegroups/rg-spoke-demo/providers/microsoft.insights/components/logicappdatasyncinsight"]
#   severity            = "Sev3"
#   action_group {
#     ids = ["/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourcegroups/rg-spoke-demo/providers/microsoft.insights/actiongroups/application insights smart detection"]
#   }
#   depends_on = [
#     azurerm_resource_group.resource_group,
#   ]
# }
# resource "azurerm_monitor_action_group" "res-60" {
#   name                = "Application Insights Smart Detection"
#   resource_group_name = "rg-spoke-demo"
#   short_name          = "SmartDetect"
#   arm_role_receiver {
#     name                    = "Monitoring Contributor"
#     role_id                 = "749f88d5-cbae-40b8-bcfc-e573ddc772fa"
#     use_common_alert_schema = true
#   }
#   arm_role_receiver {
#     name                    = "Monitoring Reader"
#     role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
#     use_common_alert_schema = true
#   }
#   depends_on = [
#     azurerm_resource_group.resource_group,
#   ]
# }
resource "azurerm_application_insights" "res-61" {
  application_type    = "web"
  location            = "francecentral"
  name                = "logicappdatasyncinsight"
  resource_group_name = "rg-spoke-demo"
  sampling_percentage = 0
  workspace_id        = "/subscriptions/023b2039-5c23-44b8-844e-c002f8ed431d/resourceGroups/DefaultResourceGroup-PAR/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-023b2039-5c23-44b8-844e-c002f8ed431d-PAR"
  depends_on = [
    azurerm_resource_group.resource_group,
  ]
}
