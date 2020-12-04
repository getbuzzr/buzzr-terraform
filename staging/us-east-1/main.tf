terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  
  assume_role {
    role_arn = "arn:aws:iam::732983264044:role/staging_admin"
  }

}