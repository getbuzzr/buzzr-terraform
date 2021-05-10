resource "aws_acm_certificate" "dev_auth_getbuzzr_co" {
  domain_name       = "staging.auth.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "dev_api_getbuzzr_co" {
  domain_name       = "staging.api.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_acm_certificate" "staging_static_getbuzzr_co" {
  domain_name       = "staging.static.getbuzzr.co"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
