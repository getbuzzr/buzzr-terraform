terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }

  }
  backend "s3" {
    bucket = "buzzr-terraform-state-prod"
    key    = "us-east-1/terraform.state"
    region = "us-east-1"
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::995213493585:role/prod_admin"
  }

}
