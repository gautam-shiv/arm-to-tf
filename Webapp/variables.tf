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
    condition     = contains(["lab", "dev", "pro", "qa"], var.environmentName)
    error_message = "Argument \"environmentName\" must be either \"lab\", \"dev\", \"qa\" or \"pro\"."
  }
}

variable "webSiteName" {
  type         =  string
  description  =  "Name for the WebSite."
}

variable "skusize" {
  type         =  int
  description  =  "Describes plan's instance count"
  default      =  1

  validation {
    condition     = var.skusize > 0 && var.skusize < 4
    error_message = "Sku capacity should be between 1 and 3"
  }
}

variable "skuname" {
  type         =  string
  description  =  "Disk sku name"
  default      =  "Standard_LRS"

  validation {
    condition  = contains([ "F1",
          "D1",
          "B1",
          "B2",
          "B3",
          "S1",
          "S2",
          "S3",
          "P1",
          "P2",
          "P3",
          "P4" ], var.skuname)
    error_message = "Argument \"skuname\" must be either \"F1\", \"D1\", \"B1\" or \"B2\"."
  }
}
