provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
  tags     = {
        environment = "Terraform Demo"
    }
}

resource "azurerm_eventhub_cluster" "dd-ehc" {
  name                = "${lower(var.projectName)}-${lower(var.zone)}-${lower(var.environmentName)}-ehc"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  sku_name            = "Dedicated_1"
}
