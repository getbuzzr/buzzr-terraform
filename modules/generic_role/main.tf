resource "aws_iam_role_policy" "default_policy" {
  name       = "${var.name}_policy"
  role       = aws_iam_role.default_role.arn
  depends_on = [aws_iam_role.default_role.arn]
  policy     = var.role_policy
}

resource "aws_iam_role" "default_role" {
  name               = "${var.name}_role"
  assume_role_policy = var.assume_role_policy
}
