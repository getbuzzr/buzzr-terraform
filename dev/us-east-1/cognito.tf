resource "aws_cognito_user_pool" "default" {
  name                      = "onguard-user-pool"
  auto_verified_attributes  = ["email"]
  username_attributes       = ["email"]
  mfa_configuration         = "OPTIONAL"

  software_token_mfa_configuration {
    enabled = true
  }

  password_policy {
    minimum_length  = 8
    require_symbols = false
  }
}

resource "aws_cognito_user_pool_domain" "default" {
  user_pool_id  = aws_cognito_user_pool.default.id
  domain        = "onguard-dev"
}

resource "aws_cognito_identity_provider" "okta" {
  user_pool_id  = aws_cognito_user_pool.default.id
  provider_name = "Okta"
  provider_type = "SAML"

  attribute_mapping = {
    email       = "email"
    family_name = "lastName"
    given_name  = "firstName"
  }

  provider_details = {
    MetadataURL = "https://dev-4181175.okta.com/app/exk1lkocfKhH8ytxx5d6/sso/saml/metadata"
  }

}

