data "aws_ssm_parameter" "google_client_secret" {
  name = aws_ssm_parameter.cognito_google_client_secret.name
}

data "aws_ssm_parameter" "apple_client_private_key" {
  name = aws_ssm_parameter.cognito_apple_client_private_key.name
}

data "aws_ssm_parameter" "facebook_client_secret" {
  name = aws_ssm_parameter.cognito_facebook_client_secret.name
}
locals {
  cognito_idp_provider_name = "COGNITO"
}

resource "aws_cognito_user_pool" "user_pool" {
  name                     = "getbuzzr-user-pool"
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

  schema {
    attribute_data_type = "String"
    name                = "given_name"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }
  schema {
    attribute_data_type = "String"
    name                = "family_name"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }
  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }

  lambda_config {
    pre_sign_up       = module.cognito_presignup_trigger.arn
    post_confirmation = module.cognito_postsignup_trigger.arn
  }
  lifecycle {
    ignore_changes = [
      schema
    ]
  }
}
resource "aws_cognito_user_pool_domain" "default" {
  user_pool_id    = aws_cognito_user_pool.user_pool.id
  domain          = "dev.auth.getbuzzr.co"
  certificate_arn = aws_acm_certificate.dev_auth_getbuzzr_co.arn
}

module "mobile_app_client" {
  source          = "../../modules/saml_app_client"
  user_pool_id    = aws_cognito_user_pool.user_pool.id
  app_client_name = "mobile_app_client"
  supported_identity_providers = [
    local.cognito_idp_provider_name,
    aws_cognito_identity_provider.google.provider_name,
    aws_cognito_identity_provider.apple.provider_name,
    aws_cognito_identity_provider.facebook.provider_name
  ]
  default_redirect_uri = "https://oauth.getbuzzr.co/"
  callback_urls        = ["https://oauth.getbuzzr.co/"]
  logout_urls          = []
  depends_on = [
    aws_cognito_identity_provider.google,
    aws_cognito_identity_provider.apple
  ]
}


resource "aws_cognito_identity_provider" "google" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email profile openid"
    client_id        = "528145652504-drk23p55f345sol253edv6fel703d22i.apps.googleusercontent.com"
    client_secret    = data.aws_ssm_parameter.google_client_secret.value
  }

  attribute_mapping = {
    email       = "email"
    given_name  = "given_name"
    family_name = "family_name"
    username    = "sub"
    picture     = "picture"

  }
}

resource "aws_cognito_identity_provider" "facebook" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "Facebook"
  provider_type = "Facebook"

  provider_details = {
    authorize_scopes = "public_profile,email"
    client_id        = "761770857810778"
    client_secret    = data.aws_ssm_parameter.facebook_client_secret.value
    api_version      = "v6.0"
  }

  attribute_mapping = {
    email       = "email"
    given_name  = "first_name"
    family_name = "last_name"
    picture     = "cover"

  }
}

resource "aws_cognito_identity_provider" "apple" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "SignInWithApple"
  provider_type = "SignInWithApple"

  provider_details = {
    client_id        = "com.sensnet.buzzr.auth"
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


resource "aws_cognito_user_pool" "rider_pool" {
  name                     = "getbuzzr-rider-pool"
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

  schema {
    attribute_data_type = "String"
    name                = "given_name"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }
  schema {
    attribute_data_type = "String"
    name                = "family_name"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }
  schema {
    attribute_data_type = "String"
    name                = "email"
    required            = true
    string_attribute_constraints {
              max_length = "2048"
              min_length = "0"
            }
  }

  lambda_config {
    pre_sign_up       = module.rider_cognito_presignup_trigger.arn
    post_confirmation = module.rider_cognito_postsignup_trigger.arn
  }
  lifecycle {
    ignore_changes = [
      schema
    ]
  }
}
resource "aws_cognito_user_pool_client" "rider_app_client" {
  name = "rider-app-client"

  user_pool_id = aws_cognito_user_pool.rider_pool.id
}


# NOT SUPPORTED CORRECTLY YET BY TERRAFORM
# resource "aws_cognito_user_pool_ui_customization" "ui_customization" {
#   css        = "}a{color:#26DBB0}label{color:white !important}span {color: white !important;}.legalText-customizable {display:none}.background-customizable{background-color:#070D28 !important}.inputField-customizable{border: 1px solid #26DBB0;}.submitButton-customizable{background-color:#26DBB0 !important}.banner-customizable{background:#070D28 !important}"
#   image_file = filebase64("../../assets/img/Buzzr_Logo_Teal.png")

#   user_pool_id = aws_cognito_user_pool_domain.default.user_pool_id
# }
