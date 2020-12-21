resource "aws_acm_certificate" "staging_auth_onguard_co" {
  domain_name       = "staging.auth.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}