variable "role_name" {
  type        = string
  description = "(required)The name of the role"
}

variable "policy_document" {
  description = "(required)The policy document"
  type        = string
}

variable "assume_role_policy" {
  type        = string
  description = "(required) assume role policy"
}

variable "description" {
  type        = string
  description = "(optional)Description"
  default     = ""
}
