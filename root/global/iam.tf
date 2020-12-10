resource "aws_iam_user" "cicd_deploy" {
  name = "cicd_deploy"
  path = "/system/"

  tags = {
    role = "ci/cd deploy"
  }
}

resource "aws_iam_access_key" "cicd_accesskey" {
  user = aws_iam_user.cicd_deploy.name
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "cicd"
  user = aws_iam_user.cicd_deploy.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

output "secret" {
  value = aws_iam_access_key.cicd_accesskey.secret
}
