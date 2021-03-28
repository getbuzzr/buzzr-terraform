resource "aws_acm_certificate" "oauth_getbuzzr_co" {
  domain_name       = "oauth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "auth_getbuzzr_co" {
  domain_name       = "auth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}