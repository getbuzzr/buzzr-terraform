resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  filename      = "${path.module}/files/empty.zip"
  
  # if subnets present then vpc is also
  dynamic "vpc_config" {
    for_each = var.subnets != null && var.security_groups != null ? [true] : []
    content {
      security_group_ids = var.subnets
      subnet_ids         = var.security_groups
    }
  }

  runtime = var.runtime

}
