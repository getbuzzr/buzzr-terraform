resource "aws_acm_certificate" "oauth_onguard_co" {
  domain_name       = "oauth.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}