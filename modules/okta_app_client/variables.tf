variable "userpool_id" {
    type = string
    description = "(required)This is the id of the user pool"
}

variable "callback_urls" {
  type = list(string)
  description = "This is the list of callback urls allowed"
  default = []
}

variable "defaut_redirect_uri" {
    type = string
    description = "This is the default reirect uri"
    default = ""
}

variable "logout_urls" {
    type = list(string)
    description = "This is a list of logout urls allowed"
    default = []
}



