resource "aws_cognito_user_pool_client" "okta" {
  name         = "okta_app_client"
  user_pool_id = var.user_pool_id

  generate_secret = true

  allowed_oauth_flows = ["implicit"]

  allowed_oauth_scopes = ["email", "openid"]

  callback_urls = ["https://google.ca"]

  default_redirect_uri = var.default_redirect_uri

  logout_urls = var.logout_urls
}
