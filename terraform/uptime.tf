
#############################################
#             Resource Groups               #
#############################################

resource "azurerm_resource_group" "rg-uptime-shared" {
  name     = "rg-uptime-shared"
  location = var.default_location
  provider = azurerm.dev
}
resource "azurerm_resource_group" "rg-uptime" {
  name     = "rg-uptime"
  location = var.default_location
  provider = azurerm.dev
}

#############################################
#               App Services                #
#############################################

resource "azurerm_service_plan" "linux-01" {
  name                = "linux-01"
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg-uptime-shared.name
  os_type             = "Linux"
  sku_name            = "FREE"

  provider = azurerm.dev
}

resource "azurerm_app_service" "app-uptime" {
  name                = "app-uptime"
  location            = var.default_location
  resource_group_name = azurerm_resource_group.rg-uptime.name
  app_service_plan_id = azurerm_app_service_plan.linux-01.id
  tags                = azurerm_resource_group.rg-uptime.tags

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|geircode/louislam-uptime-kuma:latest"
    # linux_fx_version = "DOCKER|louislam/uptime-kuma:latest"
  }

  # DATA_DIR sets the database location. /uptime is stored from a "docker commit"
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "true"
    "DATA_DIR"                            = "/uptime"
    "UPTIME_KUMA_PORT"                    = "80"
  }

  logs {
    detailed_error_messages_enabled = true
    failed_request_tracing_enabled  = true

    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 35
      }
    }
  }

  depends_on = [
    azurerm_app_service_plan.linux-01,
  ]

  provider = azurerm.dev
}
