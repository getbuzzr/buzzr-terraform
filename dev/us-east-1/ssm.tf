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