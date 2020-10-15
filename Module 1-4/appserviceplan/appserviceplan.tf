provider "azurerm" {
    version = "~>2.0"
    features {}
}

resource "azurerm_app_service_plan" "appserviceplan" {
    name                = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}plan"
    location            = var.rglocation
    resource_group_name = var.rgname
    sku {
        tier = "Dynamic"
        size = "Y1"
    }
}
