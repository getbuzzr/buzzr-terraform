resource "aws_s3_bucket" "adfs_saml_configurations_dev" {

  bucket = "adfs-saml-configurations-dev"
  acl    = "public-read"

  tags = {
    Name        = "adfs configurations"
    Environment = "dev"
  }
}
