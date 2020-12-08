terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
  backend "s3" {
    bucket = "onguard-staging-terraform-state"
    key    = "us-east-1/terraform.state"
    region = "us-east-1"
  }
}

