variable "rgname" {
    type    = string
    default = "myrg"
}
variable "rglocation" {
    type    = string
    default = "eastus"
}
variable "projectName" {
    type    = string
    default = "projectParam"
}
variable "dataBaseName" {
    type    = string
    default = "dataBaseParam"
}
variable "envName" {
    type    = string
    default = "dev"
}
variable "zone" {
    type    = string
    default = ""
}
variable "adminLogin" {
    type    = string
    default = "adminLogin1"
}
variable "adminLoginPassword" {
    type    = string
    default = "abcdef123!@"
}
variable "collation" {
    type = string
    default = "SQL_Latin1_General_CP1_CI_AI"
}
variable "maxSizeBytes" {
    type = string
    default = "1073741824"
}
variable "database_edition" {
    type = string
    default = "Basic"
}
variable "sku" {
    type = string
    default = "standard"
}
variable "tenantid" {
    type = string
    default = "cef04b19-7776-4a94-b89b-375c77a8f936"
}