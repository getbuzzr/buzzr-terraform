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
    sid = "s3full"

    actions = [
      "s3:*",
    ]

    resources = [
      "*"
    ]
  }


  statement{
    sid="cloudformationfull"

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
    sid = "elasticloadbalancingfull"
    
    actions = [
      "elasticloadbalancing:*"
    ]
    
    resources = [
      "*"
    ]
  }
  statement {
    sid = "autoscalingfull"

    actions = [
      "autoscaling:*",
    ]

    resources = [
      "*"
    ]
  }
  statement {
    sid = "ec2full"

    actions = [
      "ec2:*",
    ]

    resources = [
      "*"
    ]
  }
  statement {
    sid = "iamfull"

    actions = [
      "iam:*",
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
  statement{
    sid = "logfull"
    
    actions = [
      "logs:*"
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
        "arn:aws:iam::980636768267:role/cicd_role"
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
