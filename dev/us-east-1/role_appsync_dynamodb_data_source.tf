data "aws_iam_policy_document" "appsync_dynamodb_data_source_policy" {
  statement {
    sid = "AppSyncDynamoDBDataSourcePermissions"

    actions = [
      "dynamodb:*"
    ]

    resources = [
      "arn:aws:dynamodb:us-east-1:*:table/live_checkin"
    ]
  }
}

data "aws_iam_policy_document" "appsync_dynamodb_data_source_arp" {
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

module "appsync_dynamodb_data_source_role" {
  source             = "../../modules/generic_role"
  role_name          = "appsync_dynamodb_data_source"
  description        = "The role that the AppSync DynamoDB data source assumes."
  assume_role_policy = data.aws_iam_policy_document.appsync_dynamodb_data_source_policy.json
  policy_document    = data.aws_iam_policy_document.appsync_dynamodb_data_source_arp.json
}

