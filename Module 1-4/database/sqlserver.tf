
resource "azurerm_sql_server" "sqlserver" {
    name                         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sql"
    location                     = var.rglocation
    resource_group_name          = var.rgname
    administrator_login          = "adm${var.dataBaseName}"    
    administrator_login_password = "${upper(var.envName)}!${var.dataBaseName}admin"
    version                      = "12.0"
    tags = {
        displayName = "SqlServer"
    }
}

resource "azurerm_sql_database" "database" {
    name                = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqldb"
    resource_group_name = var.rgname
    location            = var.rglocation
    server_name         = azurerm_sql_server.sqlserver.name
    collation           = var.collation
    max_size_bytes      = var.maxSizeBytes
    edition             = var.database_edition      #capacity missing
    tags = {
        displayName = "Database"
    }
}

resource "azurerm_sql_firewall_rule" "example" {
    name                = "AllowAllWindowsAzureIps"
    resource_group_name = var.rgname
    server_name         = azurerm_sql_server.sqlserver.name
    start_ip_address    = "0.0.0.0"
    end_ip_address      = "0.0.0.0"
}

resource "azurerm_key_vault" "keyvault" {
    name                = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv"
    location            = var.rglocation
    resource_group_name = var.rgname
    sku_name            = var.sku
    tenant_id           = var.tenantid
}

resource "azurerm_key_vault_secret" "kv1" {
    name         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv--${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqlConnString"
    value        = "Data Source=tcp:${azurerm_sql_server.sqlserver.fully_qualified_domain_name},1433;Initial Catalog=var.databaseName;User Id= var.adminLogin@${azurerm_sql_server.sqlserver.name};Password=var.adminLoginPassword;"
    key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "kv2" {
    name         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv--${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqlsqlServerName"
    value        = azurerm_sql_server.sqlserver.fully_qualified_domain_name
    key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "kv3" {
    name         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv--${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqldatabaseName"
    value        = azurerm_sql_database.database.name
    key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "kv4" {
    name         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv--${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqlsqlAdministratorLogin"
    value        = var.adminLogin
    key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "kv5" {
    name         = "${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}kv--${lower(var.projectName)}${lower(var.zone)}-${lower(var.envName)}sqlsqlAdministratorLoginPassword"
    value        = var.adminLoginPassword
    key_vault_id = azurerm_key_vault.keyvault.id
}