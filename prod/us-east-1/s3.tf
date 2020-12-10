module "saml_mobile_callback" {
  source    = "git::https://github.com/cloudposse/terraform-aws-s3-website.git?ref=tags/0.12.0"
  name      = "saml_mobile_callback"
  hostname  = "oauth.onguard.co"
}