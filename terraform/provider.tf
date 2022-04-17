provider "azurerm" {
  tenant_id       = ""
  subscription_id = ""
  client_id       = ""
  alias           = "dev"
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}