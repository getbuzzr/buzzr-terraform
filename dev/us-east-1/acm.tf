resource "aws_acm_certificate" "dev_auth_onguard_co" {
  domain_name       = "dev.auth.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_api_onguard_co" {
  domain_name       = "dev.api.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_admin_onguard_co" {
  domain_name       = "dev.admin.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_static_onguard_co" {
  domain_name       = "dev.static.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
