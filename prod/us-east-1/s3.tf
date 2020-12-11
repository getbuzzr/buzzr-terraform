module "oauth_onguard_co" {
  source = "../../modules/s3_static_website_cloudfront"

aws_region = "us-east-1"
domain_name = "oauth.onguard.co"
acm_certificate_arn = aws_acm_certificate.oauth_onguard_co.arn
cicd_role_arn="arn:aws:iam::995213493585:role/cicd_role"
}