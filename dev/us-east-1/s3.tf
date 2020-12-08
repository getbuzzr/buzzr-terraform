resource "aws_s3_bucket" "adfs_saml_metadata_dev" {

  bucket = "adfs-saml-metadata-dev"
  acl    = "public-read"

  tags = {
    Name        = "adfs metadata"
    Environment = "dev"
  }
}
