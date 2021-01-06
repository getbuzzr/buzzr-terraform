variable "function_name" {
  description = "(required) The name of the function"
}

variable "role_arn" {
  description = "The role arn"
}

variable "handler" {
  description = "The function handler"
}

variable "runtime" {
  description = "The runtime"
}


variable "vpc_config"{
  description = "(map) vpc config"
}
