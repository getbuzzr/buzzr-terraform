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


variable "vpc_subnet_ids"{
  description = "(list) subnet ids"
  default     = null
}

variable "vpc_security_group_ids"{
  description = "(list) vpc security group= ids"
  default     = null
}

