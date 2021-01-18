resource "aws_s3_bucket" "adfs_saml_metadata_dev" {

  bucket = "adfs-saml-metadata-dev"
  acl    = "public-read"

  tags = {
    Name        = "adfs metadata"
    Environment = "dev"
  }
}

resource "aws_s3_bucket" "admin_panel_assets" {

  bucket = "onguard-admin-panel-dev"
  acl    = "public-read"

  tags = {
    Name        = "admin_panel"
    Environment = "dev"
  }
}

module "elb_deploy_bucket" {
  source             = "../../modules/s3_private_read"
  bucket_name          = "onguard-elb-deploy-dev"
  read_role_arn = module.elb_webserver_role.role_arn
}
