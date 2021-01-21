resource "aws_appsync_graphql_api" "default" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = var.graphql_api_name
  schema              = var.graphql_schema

  log_config {
    cloudwatch_logs_role_arn = var.cloudwatch_logs_role_arn
    field_log_level = "ERROR"
  }

  user_pool_config {
    default_action = "ALLOW"
    user_pool_id   = var.cognito_user_pool_id
  }

  additional_authentication_provider {
    authentication_type = "API_KEY"
  }
}

resource "aws_appsync_api_key" "default" {
  api_id      = aws_appsync_graphql_api.default.id
  description = "API key to allow mobile clients to download the GraphQL schema via introspection."
  expires     = "2022-01-01T00:00:00Z"
}

resource "aws_appsync_datasource" "dynamodb" {
  api_id           = aws_appsync_graphql_api.default.id
  name             = var.dynamodb_table_name
  service_role_arn = var.dynamodb_service_role_arn
  type             = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = var.dynamodb_table_name
  }
}

