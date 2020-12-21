
# Role defined for expiry trigger
data "aws_iam_policy_document" "elb_webserver_policy" {

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
  statement {
     sid = "GetECRImages"

      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage",
        "ecr:GetLifecyclePolicy",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:ListTagsForResource",
        "ecr:DescribeImageScanFindings"
      ]

      resources = [
        "*"
      ]
  }

}

data "aws_iam_policy_document" "elb_webserver_arp" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "elasticbeanstalk.amazonaws.com"
      ]
    }
  }
}

module "elb_webserver_role" {
  source             = "../../modules/generic_role"
  role_name          = "elb_webserver"
  description        = "This is the role that the ELB webserver assumes"
  assume_role_policy = data.aws_iam_policy_document.elb_webserver_arp.json
  policy_document    = data.aws_iam_policy_document.elb_webserver_policy.json
}
