
# Role defined for check in consumer
data "aws_iam_policy_document" "checkin_gateway_policy" {

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
  
}

data "aws_iam_policy_document" "checkin_gateway_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "apigateway.amazonaws.com"
      ]
    }
  }
}

module "checkin_gateway_role" {
  source             = "../../modules/generic_role"
  role_name          = "checkin_gateway"
  description        = "This is the role that the checkin apigateway assumes"
  assume_role_policy = data.aws_iam_policy_document.checkin_gateway_arp.json
  policy_document    = data.aws_iam_policy_document.checkin_gateway_policy.json
}
