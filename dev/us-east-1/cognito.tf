data "aws_ssm_parameter" "google_client_secret" {
  name = aws_ssm_parameter.cognito_google_client_secret.name
}

data "aws_ssm_parameter" "apple_client_private_key" {
  name = aws_ssm_parameter.cognito_apple_client_private_key.name
}

locals {
  okta_idp_provider_name = "Okta"
  adfs_idp_provider_name = "ADFS"
  cognito_idp_provider_name = "COGNITO"
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

  lambda_config {
    pre_sign_up = module.cognito_presignup_trigger.arn
    post_confirmation = module.cognito_postsignup_trigger.arn
  }
}
resource "aws_cognito_user_pool_domain" "default" {
  user_pool_id    = aws_cognito_user_pool.default.id
  domain          = "dev.auth.onguard.co"
  certificate_arn = aws_acm_certificate.dev_auth_onguard_co.arn
}

module "mobile_app_client" {
  source                       = "../../modules/saml_app_client"
  user_pool_id                 = aws_cognito_user_pool.default.id
  app_client_name              = "mobile_app_client"
  supported_identity_providers = [
    local.adfs_idp_provider_name,
    local.okta_idp_provider_name,
    local.cognito_idp_provider_name,
    aws_cognito_identity_provider.google.provider_name,
    aws_cognito_identity_provider.apple.provider_name
  ]
  default_redirect_uri = "https://oauth.onguard.co/"
  # add callback urls here
  callback_urls = ["https://oauth.onguard.co/"]
  # signout urls
  logout_urls = []
  depends_on  = [
    module.adfs_dev_identity_provider,
    local.okta_idp_provider_name,
    aws_cognito_identity_provider.google,
    aws_cognito_identity_provider.apple
  ]
}

module "web_app_client" {
  source                       = "../../modules/saml_app_client"
  user_pool_id                 = aws_cognito_user_pool.default.id
  app_client_name              = "web_app_client"
  supported_identity_providers = [
    local.adfs_idp_provider_name,
    local.okta_idp_provider_name,
    local.cognito_idp_provider_name,
    aws_cognito_identity_provider.google.provider_name,
    aws_cognito_identity_provider.apple.provider_name
  ]
  #default_redirect_uri
  default_redirect_uri = ""
  # add callback urls here
  callback_urls = ["https://dev.admin.onguard.co/oauthcallback"]
  # signout urls
  logout_urls = []
  depends_on  = [
    module.adfs_dev_identity_provider,
    local.okta_idp_provider_name,
    aws_cognito_identity_provider.google,
    aws_cognito_identity_provider.apple
  ]
}


module "okta_dev_identity_provider" {
  source = "../../modules/saml_identity_provider"
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
  source = "../../modules/saml_identity_provider"
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

resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.default.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email profile openid"
    client_id        = "834623945817-hnf8d5ttiaqsp87lcuc2pdpf1qm7sotb.apps.googleusercontent.com"
    client_secret    = data.aws_ssm_parameter.google_client_secret.value
  }

  attribute_mapping = {
    email       = "email"
    given_name  = "given_name"
    family_name = "family_name"
    username    = "sub"
  }
}

resource "aws_cognito_identity_provider" "apple" {
  user_pool_id  = aws_cognito_user_pool.default.id
  provider_name = "SignInWithApple"
  provider_type = "SignInWithApple"

  provider_details = {
    client_id        = "com.sensnet.onguard.auth"
    team_id          = "E4M7QG8VQK"
    key_id           = "CGX5ZW85KD"
    private_key      = data.aws_ssm_parameter.apple_client_private_key.value
    authorize_scopes = "email name"
  }

  attribute_mapping = {
    email       = "email"
    given_name  = "firstName"
    family_name = "lastName"
    username    = "sub"
  }
}