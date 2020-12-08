resource "aws_s3_bucket" "adfs_saml_metadata_staging" {

  bucket = "adfs-saml-metadata-staging"
  acl    = "public-read"

  tags = {
    Name        = "adfs metadata"
    Environment = "dev"
  }
}
