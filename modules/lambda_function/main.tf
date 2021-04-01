locals {
  environment_map = var.variables == null ? [] : [var.variables]
}

resource "aws_lambda_function" "default" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  filename      = "${path.module}/files/empty.zip"
  layers = var.lambda_layer_arns 
  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }
  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }
  runtime = var.runtime
  timeout = var.timeout
}
