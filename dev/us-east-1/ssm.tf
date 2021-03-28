# ===========Manual set secrets ==========
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
  # Placeholder key for validation purposes
  value = <<EOT
  -----BEGIN PRIVATE KEY-----
MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgqWAZw99VDTY11Q5v
ZKEMKmmOnbmxaO0P/RnCOW0mcnqgCgYIKoZIzj0DAQehRANCAASvSCaRofuf9OUh
CPgKyn5qcgEhpGa2w+ur7e+IgSur01ZLN7W+jAi1FdzV2wutz2u5qDyhIKUWhh1L
wCxzxqX4
-----END PRIVATE KEY-----
  EOT
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
# =================================================
data "aws_ssm_parameter" "api_db_server_password" {
  name = aws_ssm_parameter.api_db_server_password.name
}

resource "aws_ssm_parameter" "api_db_database_uri" {
  name  = "api_db_database_uri"
  type  = "SecureString"
  value = "mysql://${module.api_db_server.master_username}:${data.aws_ssm_parameter.api_db_server_password.value}@${module.api_db_server.endpoint}/${module.api_db_server.database_name}"
}

resource "aws_ssm_parameter" "cognito_client_pool" {
  name  = "cognito_client_pool"
  type  = "SecureString"
  value = aws_cognito_user_pool.default.id
}


resource "aws_ssm_parameter" "api_ecr_repo" {
  name  = "api_ecr_repo"
  type  = "SecureString"
  value = aws_ecr_repository.buzzr_dev_api.repository_url
}

resource "aws_ssm_parameter" "gcm_api_key" {
  name  = "gcm_api_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "apns_private_key" {
  name  = "apns_private_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "apns_certificate" {
  name  = "apns_certificate"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}



