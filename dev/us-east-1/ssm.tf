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

resource "aws_ssm_parameter" "cognito_facebook_client_secret" {
  name  = "cognito_facebook_client_secret"
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
  value = "mysql://${aws_db_instance.buzzr_dev_db.username}:${data.aws_ssm_parameter.api_db_server_password.value}@${aws_db_instance.buzzr_dev_db.endpoint}/${aws_db_instance.buzzr_dev_db.name}"
}

resource "aws_ssm_parameter" "cognito_client_pool" {
  name  = "cognito_client_pool"
  type  = "SecureString"
  value = aws_cognito_user_pool.cognito_user_pool_dev.id
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

resource "aws_ssm_parameter" "stripe_secret_key" {
  name  = "stripe_secret_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


resource "aws_ssm_parameter" "slack_delivery_webhook_endpoint" {
  name  = "slack_delivery_webhook_endpoint"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "facebook_api_key" {
  name  = "facebook_api_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "stripe_webhook_token" {
  name  = "stripe_webhook_token"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "retool_auth_key" {
  name  = "retool_auth_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "google_maps_api_key" {
  name  = "google_maps_api_key"
  type  = "SecureString"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "ios_sns_platform_arn" {
  name  = "ios_sns_platform_arn"
  type  = "SecureString"
  value = aws_sns_platform_application.apns_application.arn
}

resource "aws_ssm_parameter" "gcm_sns_platform_arn" {
  name  = "gcm_sns_platform_arn"
  type  = "SecureString"
  value = aws_sns_platform_application.gcm_application.arn
}

resource "aws_ssm_parameter" "is_store_open" {
  name  = "is_store_open"
  type  = "String"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "num_riders_working" {
  name  = "num_riders_working"
  type  = "String"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
resource "aws_ssm_parameter" "twilio_auth_token" {
  name  = "twilio_auth_token"
  type  = "String"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "twilio_account_sid" {
  name  = "twilio_account_sid"
  type  = "String"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "redis_hostname" {
  name  = "redis_host_name"
  type  = "String"
  value = aws_elasticache_cluster.buzzr_redis.cache_nodes.0.address
}

resource "aws_ssm_parameter" "opening_hours" {
  name  = "opening_hours"
  type  = "String"
  value = " "
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "aws_ssm_parameter" "marketing_topic_arn" {
  name  = "marketing_topic_arn"
  type  = "String"
  value = aws_sns_topic.marketing_topic.arn
}
