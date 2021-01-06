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


variable "subnets"{
  description = "(list)the subnets ids associated to this lambda"
}

variable "security_groups"{
  description = "(list)The security group ids associated to this lambda"
}