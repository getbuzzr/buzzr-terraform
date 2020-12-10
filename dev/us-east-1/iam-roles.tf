data "aws_iam_policy_document" "presignup_lambda_policy" {

  statement {
    sid = "PresignupCloudwatchLogs"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:us-east-1:*:*"
    ]
  }

  statement {
    sid = "PresignupInvokePermissions"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      "arn:aws:lambda:us-east-1:*:function:cognito_presignup_trigger"
    ]
  }

}

data "aws_iam_policy_document" "presignup_lambda_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

module "presignup_lambda_role" {
  source             = "../../modules/generic_role"
  role_name          = "presignup_lambda"
  description        = "This is the role that the cognito presignup lambda function assumes."
  assume_role_policy = data.aws_iam_policy_document.presignup_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.presignup_lambda_policy.json
}


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

}

data "aws_iam_policy_document" "presignup_lambda_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::358881498638:user/terraform"
      ]
    }
  }
}

module "cicd_role" {
  source             = "../../modules/generic_role"
  role_name          = "cicd_role"
  description        = "This is the role that allows root cicd user to deploy code to dev"
  assume_role_policy = data.aws_iam_policy_document.presignup_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.presignup_lambda_policy.json
}
