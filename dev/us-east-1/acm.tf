resource "aws_acm_certificate" "dev_auth_getbuzzr_co" {
  domain_name       = "dev.auth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_api_getbuzzr_co" {
  domain_name       = "dev.api.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_admin_getbuzzr_co" {
  domain_name       = "dev.admin.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_static_getbuzzr_co" {
  domain_name       = "dev.static.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_riderauth_getbuzzr_co" {
  domain_name       = "dev.riderauth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_oauth_getbuzzr_co" {
  domain_name       = "dev.oauth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}