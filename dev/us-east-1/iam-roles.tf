data "aws_iam_policy_document" "presignup_lambda_policy" {

  statement {
    sid = "presignup_cloudwatch_logs"

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
    sid = "presignup_invoke_permissions"

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
  name               = "presignup_lambda"
  description        = "This is the role that the cognito presignup lambda function assumes."
  assume_role_policy = data.aws_iam_policy_document.presignup_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.presignup_lambda_policy.json
}
