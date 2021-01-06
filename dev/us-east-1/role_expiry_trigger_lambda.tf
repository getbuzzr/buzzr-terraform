
# Role defined for expiry trigger
data "aws_iam_policy_document" "expiry_trigger_lambda_policy" {

  statement {
    sid = "CheckinCloudwatchLogs"

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
    sid = "ec2deploy"

    actions = [
      "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "CheckinInvokePermissions"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      "arn:aws:lambda:us-east-1:*:function:expiry_trigger"
    ]
  }

  statement {
    sid = "ExpiryLiveCheckinReadWrite"

    actions = [
      "dynamodb:*"
    ]

    resources = [
      "arn:aws:dynamodb:us-east-1:*:table/CheckInStatus"
    ]
  }
  statement {
     sid = "ExpirynGetAPIDbPassword"

      actions = [
        "ssm:GetParameter*",
        "ssm:DescribeParameters"
      ]

      resources = [
        "arn:aws:ssm:us-east-1:*:parameter/api_db_server_password"
      ]
  }
  statement {
     sid = "CheckinSQSEnqueue"

      actions = [
        "sqs:SendMessage",
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]

      resources = [
        "arn:aws:sqs:us-east-1:*:checkin_queue"
      ]
  }

}

data "aws_iam_policy_document" "expiry_trigger_lambda_arp" {
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

module "expiry_trigger_lambda_role" {
  source             = "../../modules/generic_role"
  role_name          = "expiry_trigger_lambda"
  description        = "This is the role that the expiry trigger assumes"
  assume_role_policy = data.aws_iam_policy_document.expiry_trigger_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.expiry_trigger_lambda_policy.json
}
