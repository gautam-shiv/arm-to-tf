provider "azurerm" {
    version = "~>2.0"
    features {}
}

resource "azurerm_app_service_plan" "appserviceplan" {
    name                         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}premiumplan"
    location                     = var.rglocation
    resource_group_name          = var.rgname
    kind                         = "elastic"
    maximum_elastic_worker_count = 20
    reserved                     = false
    per_site_scaling             = false
    sku {
        tier     = "ElasticPremium"
        size     = "EP1"
        capacity = 1
    }
}
