resource "aws_s3_bucket" "adfs_saml_metadata_dev" {

  bucket = "adfs-saml-metadata-dev"
  acl    = "public-read"

  tags = {
    Name        = "adfs metadata"
    Environment = "dev"
  }
}


module "elb_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "buzzr-elb-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}

module "dev_static_buzzr_co" {
  source = "../../modules/s3_static_website_cloudfront"

  aws_region          = "us-east-1"
  domain_name         = "dev.static.buzzr.co"
  # acm_certificate_arn = aws_acm_certificate.dev_static_buzzr_co.arn
  admin_role_arn      = module.elb_webserver_role.role_arn
}
