terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }

  backend "s3" {
  bucket = "onguard-dev-terraform-state"
  key    = "global/terraform.state"
  region = "us-east-1"
}

}

provider "aws" {
  profile = "default"

  assume_role {
    role_arn = "arn:aws:iam::073157105290:role/dev_admin"
  }
}
