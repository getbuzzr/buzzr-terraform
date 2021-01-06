resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  filename      = "${path.module}/files/empty.zip"
  # if subnets present then vpc is also
  if var.subnets {
    vpc_config {
      subnet_ids         = var.subnets
      security_group_ids = var.security_groups
    } 
  }

  runtime = var.runtime

}
