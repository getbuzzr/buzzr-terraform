variable "user_pool_id" {
    type = string
    description = "(required)This is the id of the user pool"
}

variable "attribute_mapping" {
    description = "This is the attribute map that must be included"
    type = map(string)
    default = {}
}

variable "metadata_url" {
    type = string
    description = "This is the metadata url provided by Okta"
}
