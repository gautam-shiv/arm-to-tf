variable "rgname" {
    type    = string
    default = "myrg"
}
variable "rglocation" {
    type    = string
    default = "eastus"
}
variable "projectname" {
    type    = string
    default = "projectParam"
    description = "Name for the project"
}
variable "environmentName" {
    type    = string
    default = "dev"
    description = "Name for the environment"
}
variable "zone" {
    type        = string
    default     = ""
    description = "Describes the performance level for Edition"
}
variable "skuname" {
    type        = string
    default     = "Developer_1"
    description = "The instance name and size of this API Management service."
}

variable "pubname" {
    type        = string
    default     = "publisherNameParam"
    description = "The name of the owner of the service"
}

variable "pubmail" {
    type        = string
    default     = "publisherEmailParam"
    description = "The email address of the owner of the service"
}