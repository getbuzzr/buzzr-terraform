resource "aws_iam_user" "cicd_deploy" {
  name = "cicd_deploy"

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
                "Sid": "AllowAssumeRole",
                "Effect": "Allow",
                "Action": "sts:*",
                "Resource": [
                    "arn:aws:iam::073157105290:role/cicd_role",
                    "arn:aws:iam::995213493585:role/cicd_role",
                    "arn:aws:iam::732983264044:role/cicd_role"
                ]
            }
        ]
    }
    EOF
}

output "secret" {
  value = aws_iam_access_key.cicd_accesskey.secret
}
