resource "aws_s3_bucket" "adfs_saml_configurations_staging" {

  bucket = "adfs-saml-configurations-staging"
  acl    = "public-read"

  tags = {
    Name        = "adfs configurations"
    Environment = "dev"
  }
}
