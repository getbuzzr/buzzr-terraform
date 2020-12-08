variable "user_pool_id" {
  type        = string
  description = "(Required) The id of the user pool."
}

variable "callback_urls" {
  type        = list(string)
  description = "(Optional) List of allowed callback URLs for the identity providers."
  default     = []
}

variable "default_redirect_uri" {
  type        = string
  description =  "(Optional) The default redirect URI. Must be in the list of callback URLs."
  default     = ""
}

variable "logout_urls" {
  type        = list(string)
  description = "(Optional) List of allowed logout URLs for the identity providers."
  default     = []
}

variable "app_client_name" {
  type        = string
  description = "The app client name."
}

variable "supported_identity_providers" {
  type = list(string)
}
