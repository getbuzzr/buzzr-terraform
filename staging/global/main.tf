terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }

  backend "s3" {
    bucket = "buzzr-terraform-state-stage"
    key    = "global/terraform.state"
    region = "us-east-1"
  }
}
