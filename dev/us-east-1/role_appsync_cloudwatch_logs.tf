data "aws_iam_policy_document" "appsync_cloudwatch_logs_policy" {
  statement {
    sid = "AppSyncCloudWatchLogsPermissions"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}

data "aws_iam_policy_document" "appsync_cloudwatch_logs_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "appsync.amazonaws.com"
      ]
    }
  }
}

module "appsync_cloudwatch_logs_role" {
  source             = "../../modules/generic_role"
  role_name          = "appsync_cloudwatch_logs"
  description        = "The role that AppSync assumes to write logs to CloudWatch."
  assume_role_policy = data.aws_iam_policy_document.appsync_cloudwatch_logs_arp.json
  policy_document    = data.aws_iam_policy_document.appsync_cloudwatch_logs_policy.json
}

