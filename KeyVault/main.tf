provider "azurerm" {
  version = "~>2.0"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  } 
}

resource "azurerm_resource_group" "myrg" {
  name     = "dd-test-sample-rg-pasv"
  location = "centralindia"
  tags     = {
        environment = "Terraform Demo"
    }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "example" {
  name                            = "${lower(var.projectName)}-${lower(var.zone)}-${lower(var.environmentName)}-kv"
  location                        = azurerm_resource_group.myrg.location
  resource_group_name             = azurerm_resource_group.myrg.name
  enabled_for_disk_encryption     = var.enabledForDiskEncryption
  enabled_for_template_deployment = var.enabledForTemplateDeployment
  tenant_id                       = data.azurerm_subscription.current.tenant_id

  sku_name = var.skuName

  access_policy {
    tenant_id                     = data.azurerm_subscription.current.tenant_id
    object_id                     = var.objectId
    key_permissions               = var.keysPermissions
    secret_permissions            = var.secretsPermissions
  }

  network_acls {
    default_action                = "Allow"
    bypass                        = "AzureServices"
  }

  tags = {
    environment                   = "Terraform Demo"
  }
}