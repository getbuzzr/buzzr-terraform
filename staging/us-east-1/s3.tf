resource "aws_s3_bucket" "adfs_saml_configurations" {

  bucket = "adfs-saml-configurations"
  acl    = "public-read"

  tags = {
    Name        = "adfs configurations"
    Environment = "dev"
  }
}
