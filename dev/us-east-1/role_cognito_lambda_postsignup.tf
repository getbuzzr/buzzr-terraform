data "aws_iam_policy_document" "postsignup_lambda_policy" {

  statement {
    sid = "CloudwatchLogs"

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
    sid = "PostsignupInvokePermissions"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      "arn:aws:lambda:us-east-1:*:function:cognito_postsignup_trigger"
    ]
  }

}

data "aws_iam_policy_document" "postsignup_lambda_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
        "cognito-idp.amazonaws.com"
      ]
    }
  }
}

module "postsignup_lambda_role" {
  source             = "../../modules/generic_role"
  role_name          = "postsignup_lambda"
  description        = "This is the role that the cognito postsignup lambda function assumes."
  assume_role_policy = data.aws_iam_policy_document.postsignup_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.postsignup_lambda_policy.json
}

