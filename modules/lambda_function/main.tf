resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  filename      = "${path.module}/files/empty.zip"
  
  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  runtime = var.runtime

}
