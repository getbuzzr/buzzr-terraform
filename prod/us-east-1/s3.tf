module "oauth_getbuzzr_co" {
  source              = "../../modules/s3_static_website_cloudfront"
  aws_region          = "us-east-1"
  domain_name         = "oauth.getbuzzr.co"
  acm_certificate_arn = aws_acm_certificate.oauth_getbuzzr_co.arn
  admin_role_arn      = "arn:aws:iam::980636768267:role/cicd_role"
}



module "elb_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "buzzr-elb-deploy-prod"
  read_role_arn = module.elb_webserver_role.role_arn
}


module "static_getbuzzr_co" {
    source        = "../../modules/s3_cloudfront"
    aws_region = "us-east-1"
    domain_name = "static.getbuzzr.co"
    acm_certificate_arn = aws_acm_certificate.static_getbuzzr_co.arn
    admin_role_arn = "arn:aws:iam::980636768267:role/prod_admin"
}