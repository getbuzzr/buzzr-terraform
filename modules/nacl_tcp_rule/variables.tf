variable "network_acl_id" {
  description = "(required) This is the id of the nac"
}

variable "from_port_number" {
  description = "this is the port number beginning range"
}
variable "to_port_number" {
  description = "this is the port number end range"
}

variable "rule_number" {
  description = "This is the rule number for the ruke"
}

variable "cidr_block" {
  description = "This is the cidr block"
}
