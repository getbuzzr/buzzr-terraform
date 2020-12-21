variable "db_subnet_group" {
  description = "subnet group where db is supposed to live"
}

variable "db_name" {
  description = "The name of the db"
}

variable "db_password_ssm_path" {
  description = "The path to the ssm parameter that houses the db password"
}

variable "max_capacity_unit" {
  description= "Max capacity unit for db scaling. Max 256"
}