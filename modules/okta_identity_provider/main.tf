resource "aws_cognito_identity_provider" "okta" {
  user_pool_id  = var.user_pool_id
  provider_name = "Okta"
  provider_type = "SAML"

  attribute_mapping = vars.attribute_mapping

  provider_details = {
    MetadataURL = var.metadata_url
  }

}