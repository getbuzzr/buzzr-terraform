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

variable "lambda_layer_arns"{
  description = "(list) arns of lambda layers"
  type = list(string)
  default     = null
}

variable "timeout"{
  description = "timeout of function"
  default     = 5
}
