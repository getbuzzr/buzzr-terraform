resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  filename      = "${path.module}/files/empty.zip"


  runtime = var.runtime

}
