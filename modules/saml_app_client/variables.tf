variable "user_pool_id" {
  type        = string
  description = "(required)This is the id of the user pool"
}

variable "callback_urls" {
  type        = list(string)
  description = "This is the list of callback urls allowed"
  default     = []
}

variable "default_redirect_uri" {
  type        = string
  description = "This is the default reirect uri"
  default     = ""
}

variable "logout_urls" {
  type        = list(string)
  description = "This is a list of logout urls allowed"
  default     = []
}

variable "app_client_name" {
  type        = string
  description = "This is the app client name"
}

variable "supported_identity_providers" {
  type = list(string)
}