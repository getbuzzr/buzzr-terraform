variable "aws_region" {
description = "The aws region of bucket"
}

variable "domain_name" {
    description = "The domain name"
}

variable "acm_certificate_arn"{
    description = "The acm arn"
}

variable "cicd_role_arn"{
    descrption = "cicd role arn to allow writes to bucket"
}