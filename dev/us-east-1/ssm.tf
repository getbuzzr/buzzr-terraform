resource "aws_ssm_parameter" "api_db_server_password" {
  name  = "api_db_server_password"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "cognito_google_client_secret" {
  name  = "cognito_google_client_secret"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "cognito_apple_client_private_key" {
  name = "cognito_apple_client_private_key"
  type = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}