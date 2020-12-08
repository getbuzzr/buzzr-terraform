resource "aws_iam_role_policy" "default_policy" {
  name       = "${var.role_name}_policy"
  role       = aws_iam_role.default_role.arn
  policy     = var.policy_document
}

resource "aws_iam_role" "default_role" {
  name               = "${var.role_name}_role"
  assume_role_policy = var.assume_role_policy
}
