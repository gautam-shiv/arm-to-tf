provider "azurerm" {
  version = "~>2.0"
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
  
  tags = {
       environment = "Terraform Demo"
    }
}

data "azurerm_client_config" "current" {}

# create storage account
resource "azurerm_storage_account" "mytfstorage" {
    name                     = "${lower(var.projectname)}${lower(var.zone)}${lower(var.environmentName)}st"
    resource_group_name      = azurerm_resource_group.myrg.name
    location                 = azurerm_resource_group.myrg.location
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "${var.accountReplicationType}"
    access_tier              = "Hot"

    tags = {
        environment = "Terraform Demo"
    }

}

# create storage container
resource "azurerm_storage_container" "mytfstcontainer" {
    name                     = "${lower(var.projectname)}${lower(var.zone)}${var.environmentName}default${var.containerName}"
    storage_account_name  = azurerm_storage_account.mytfstorage.name
    container_access_type    = "private"
  
    depends_on               = [azurerm_storage_account.mytfstorage]
}

# create key vault
resource "azurerm_key_vault" "mytfkv" {
  name                = "${lower(var.projectname)}-${lower(var.zone)}-${var.environmentName}-default-${var.containerName}-kv"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  tags = {
    environment = "Terraform Demo"
  }

  depends_on           = [azurerm_storage_account.mytfstorage]
}

resource "azurerm_key_vault_secret" "kvsecret" {
  name         = "${lower(var.projectname)}-${lower(var.zone)}-${var.environmentName}-default-${var.containerName}-kvsecret"
  value        = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.mytfstorage.name};AccountKey=listKeys(${azurerm_storage_account.mytfstorage.id}2015-05-01-preview.key1)"
  key_vault_id = azurerm_key_vault.mytfkv.id

  tags = {
    environment = "Terraform Demo"
  }
}
