resource "aws_s3_bucket" "adfs_saml_metadata_dev" {

  bucket = "adfs-saml-metadata-dev"
  acl    = "public-read"

  tags = {
    Name        = "adfs metadata"
    Environment = "dev"
  }
}

module "dev_admin_onguard_co" {
  source = "../../modules/s3_static_website_cloudfront"

  aws_region          = "us-east-1"
  domain_name         = "dev.admin.onguard.co"
  acm_certificate_arn = aws_acm_certificate.dev_admin_onguard_co.arn
  admin_role_arn      = "arn:aws:iam::073157105290:role/cicd_role"
}

module "elb_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "onguard-elb-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}

module "dev_static_onguard_co" {
  source = "../../modules/s3_static_website_cloudfront"

  aws_region          = "us-east-1"
  domain_name         = "dev.static.onguard.co"
  acm_certificate_arn = aws_acm_certificate.dev_static_onguard_co.arn
  admin_role_arn      = module.elb_webserver_role.role_arn
}
