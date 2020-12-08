
locals {
  okta_idp_provider_name = "Okta"
  adfs_idp_provider_name = "ADFS"
}

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


module "mobile_app_client" {
  source                       = "../../modules/saml_app_client"
  user_pool_id                 = aws_cognito_user_pool.default.id
  app_client_name              = "mobile_app_client"
  supported_identity_providers = [local.okta_idp_provider_name, local.adfs_idp_provider_name]
  #TODO: replace test URL
  default_redirect_uri = "https://authtest.oglw.io/auth/callback/"
  # add callback urls here
  callback_urls = ["https://authtest.oglw.io/auth/callback/"]
  # signout urls
  logout_urls = []
  depends_on  = [module.okta_dev_identity_provider, local.adfs_idp_provider_name]
}

module "web_app_client" {
  source                       = "../../modules/saml_app_client"
  user_pool_id                 = aws_cognito_user_pool.default.id
  app_client_name              = "web_app_client"
  supported_identity_providers = [local.adfs_idp_provider_name, local.okta_idp_provider_name]
  #default_redirect_uri
  default_redirect_uri = ""
  # add callback urls here
  callback_urls = ["https://google.ca"]
  # signout urls
  logout_urls = []
  depends_on  = [module.adfs_dev_identity_provider, local.okta_idp_provider_name]
}


module "okta_dev_identity_provider" {
  source = "../../modules/identity_provider"
  # mapping attributes used to handle attributes returned by saml
  attribute_mapping = {
    email       = "email"
    given_name  = "firstName"
    family_name = "lastName"
  }
  provider_name = local.okta_idp_provider_name
  user_pool_id  = aws_cognito_user_pool.default.id
  metadata_url  = "https://dev-4181175.okta.com/app/exk1lkocfKhH8ytxx5d6/sso/saml/metadata"

}

module "adfs_dev_identity_provider" {
  source = "../../modules/identity_provider"
  # mapping attributes used to handle attributes returned by saml
  attribute_mapping = {
    email       = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
    given_name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"
    family_name = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"

  }
  provider_name = local.adfs_idp_provider_name
  user_pool_id  = aws_cognito_user_pool.default.id
  metadata_url  = "https://adfs-saml-metadata-dev.s3.amazonaws.com/adfs_test.xml"

}


