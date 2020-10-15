provider "azurerm" {
    version = "~>2.0"
    features {}
}

resource "azurerm_application_insights" "appinsight" {
    name                = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}ai"
    location            = var.rglocation
    resource_group_name = var.rgname
    application_type    = var.apptype              #Not specified in json file
}

resource "azurerm_key_vault" "keyvault" {
    name                = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv"
    location            = var.rglocation
    resource_group_name = var.rgname
    sku_name            = var.sku
    tenant_id           = var.tenantid
}