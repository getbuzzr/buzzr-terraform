resource "aws_acm_certificate" "auth_onguard_co" {
  domain_name       = "auth.onguard.co"
  validation_method = "DNS"

  subject_alternative_names = ["*.auth.onguard.co"]

  lifecycle {
    create_before_destroy = true
  }
}