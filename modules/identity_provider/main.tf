resource "aws_cognito_identity_provider" "default" {
  user_pool_id  = var.user_pool_id
  provider_name = var.provider_name
  provider_type = "SAML"

  attribute_mapping = var.attribute_mapping

  provider_details = {
    MetadataURL = var.metadata_url
  }

}
