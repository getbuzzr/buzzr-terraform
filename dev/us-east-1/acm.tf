resource "aws_acm_certificate" "dev_auth_onguard_co" {
  domain_name       = "dev.auth.onguard.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}