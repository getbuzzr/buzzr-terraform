data "aws_iam_policy_document" "cicd_policy" {

  statement {
    sid = "LambdaDeploy"

    actions = [
      "lambda:*",
    ]

    resources = [
      "arn:aws:lambda:us-east-1:*:function:*"
    ]
  }

  statement {
    sid = "s3elbperms"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::elasticbeanstalk-us-east-1*"
    ]
  }


  statement{
    sid="cloudformation_full"

    actions = [
      "cloudformation:*"
    ]

    resources = [
      "arn:aws:cloudformation:us-east-1:*:stack/*"
    ]
  }

  statement {
    sid = "CloudfrontFull"

    actions = [
      "cloudfront:*",
    ]

    resources = [
      "arn:aws:cloudfront::*:distribution/*"
    ]
  }
  statement {
    sid = "elasticbeanstalkfull"

    actions = [
      "elasticbeanstalk:*",
    ]

    resources = [
      "*"
    ]
  }


  statement {
    sid = "ssmfull"

    actions = [
      "ssm:*",
    ]

    resources = [
      "arn:aws:ssm:us-east-1:*:parameter/*"
    ]
  }
  statement {
    sid = "ecrfull"

    actions = [
      "ecr:*",
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "cicd_arp" {
  statement {
    actions = [
        "sts:AssumeRole",
        "sts:TagSession"
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::358881498638:user/cicd_deploy"
      ]
    }
  }
}

module "cicd_role" {
  source             = "../../modules/generic_role"
  role_name          = "cicd"
  description        = "This is the role that allows root cicd user to deploy code to dev"
  assume_role_policy = data.aws_iam_policy_document.cicd_arp.json
  policy_document    = data.aws_iam_policy_document.cicd_policy.json
}
