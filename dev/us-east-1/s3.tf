

module "elb_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "buzzr-elb-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}

module "admin_deploy_bucket" {
  source        = "../../modules/s3_private_read"
  bucket_name   = "buzzr-admin-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}


