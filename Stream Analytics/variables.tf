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

variable "stream_query" {
  type         =  string
  description  =  "SQL expresion for performing transformations and computations over streams of events"
}

variable "stream_analytics_name" {
  type         =  string
  description  =  "Name for the StreamAnalytics"
}

variable "num_streaming_units" {
  type         =  number
  description  =  "Number of Streaming Units"

  validation {
    condition  = "${var.num_streaming_units}" == 1 || "${var.num_streaming_units}" == 3 || "${var.num_streaming_units}"%6 == 0
    error_message = "Argument \"num_streaming_units\" must be either \"1\", \"3\", \"6\" or \"or multiple of 6\"."
  }
}
