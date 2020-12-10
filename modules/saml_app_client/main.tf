resource "aws_cognito_user_pool_client" "default" {
  name         = var.app_client_name
  user_pool_id = var.user_pool_id

  generate_secret = true

  allowed_oauth_flows_user_pool_client = true

  allowed_oauth_flows = ["implicit"]

  allowed_oauth_scopes = ["email", "openid"]

  callback_urls = var.callback_urls

  default_redirect_uri = var.default_redirect_uri

  logout_urls = var.logout_urls

  supported_identity_providers = var.supported_identity_providers
}
