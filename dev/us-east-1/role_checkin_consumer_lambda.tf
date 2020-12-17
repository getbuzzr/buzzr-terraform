
# Role defined for check in consumer
data "aws_iam_policy_document" "checkin_consumer_lambda_policy" {

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
    sid = "CheckinInvokePermissions"

    actions = [
      "lambda:InvokeFunction"
    ]

    resources = [
      "arn:aws:lambda:us-east-1:*:function:checkin_consumer"
    ]
  }
  
  statement {
      sid = "LiveCheckinReadWrite"

      actions = [
        "dynamodb:*"
      ]

      resources = [
        "arn:aws:dynamodb:us-east-1:*:table/CheckInStatus"
      ]
  }
  statement {
     sid = "CheckinGetAPIDbPassword"

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
      ]

      resources = [
        "arn:aws:sqs:us-east-1:*:checkin_queue"
      ]
  }
}

data "aws_iam_policy_document" "checkin_consumer_lambda_arp" {
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

module "checkin_consumer_lambda_role" {
  source             = "../../modules/generic_role"
  role_name          = "checkin_consumer_lambda"
  description        = "This is the role that the checkin consumer assumes"
  assume_role_policy = data.aws_iam_policy_document.checkin_consumer_lambda_arp.json
  policy_document    = data.aws_iam_policy_document.checkin_consumer_lambda_policy.json
}
