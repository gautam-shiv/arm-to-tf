variable "projectname" {
  type         =  string
  description  =  "Name for the project"
}

variable "zone" {
  type         =  string
  description  =  "Describes the performance level for Edition"
}

variable "environmentName" {
  type         =  string
  description  =  "Name for the environment"

  validation {
    condition     = contains(["lab", "dev", "pro", "qa"], "${var.environmentName}")
    error_message = "Argument \"environmentName\" must be either \"lab\", \"dev\", \"qa\" or \"pro\"."
  }
}

variable "account_replication_type" {
  type         =  string
  description  =  "Account replication type"
  default      =  "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS"], "${var.account_replication_type}")
    error_message = "Argument \"account_replication_type\" must be either \"LRS\", \"GRS\"or \"RAGRS\"."
  }
}

variable "container_name" {
  type         =  string
  description  =  "Specifies the name of the blob container."
  default      =  "logs"
}
