
resource "aws_cognito_user_pool" "default" {
  name                     = "onguard-user-pool"
  auto_verified_attributes = ["email"]
  username_attributes      = ["email"]
  mfa_configuration        = "OPTIONAL"

  software_token_mfa_configuration {
    enabled = true
  }

  password_policy {
    minimum_length  = 8
    require_symbols = false
  }
}
resource "aws_cognito_user_pool_domain" "default" {
  user_pool_id = aws_cognito_user_pool.default.id
  domain       = "onguard-auth-dev"
}


module "okta_app_client" {
  source          = "../../modules/saml_app_client"
  user_pool_id    = aws_cognito_user_pool.default.id
  app_client_name = "okta_app_client"
  #default_redirect_uri
  default_redirect_uri = ""
  # add callback urls here
  callback_urls = ["https://google.ca"]
  # signout urls
  logout_urls = []
}

module "adfs_app_client" {
  source          = "../../modules/saml_app_client"
  user_pool_id    = aws_cognito_user_pool.default.id
  app_client_name = "adfs_app_client"
  #default_redirect_uri
  default_redirect_uri = ""
  # add callback urls here
  callback_urls = ["https://google.ca"]
  # signout urls
  logout_urls = []
}


module "okta_dev_identity_provider" {
  source = "../../modules/identity_provider"
  # mapping attributes used to handle attributes returned by saml
  attribute_mapping = {}
  provider_name     = "okta_dev"
  user_pool_id      = aws_cognito_user_pool.default.id
  metadata_url      = "https://dev-4181175.okta.com/app/exk1lkocfKhH8ytxx5d6/sso/saml/metadata"

}

module "adfs_dev_identity_provider" {
  source = "../../modules/identity_provider"
  # mapping attributes used to handle attributes returned by saml
  attribute_mapping = {}
  provider_name     = "adfs_dev"
  user_pool_id      = aws_cognito_user_pool.default.id
  metadata_url      = "https://s3-hosted-adfs-xml.com"

}


