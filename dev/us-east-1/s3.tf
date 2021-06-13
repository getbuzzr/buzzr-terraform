

module "elb_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "buzzr-elb-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}

module "dev_oauth_getbuzzr_co" {
  source              = "../../modules/s3_static_website_cloudfront"
  aws_region          = "us-east-1"
  domain_name         = "dev.oauth.getbuzzr.co"
  acm_certificate_arn = aws_acm_certificate.dev_oauth_getbuzzr_co.arn
  admin_role_arn      = "arn:aws:iam::824611589741:role/cicd_role"
}