resource "aws_appsync_graphql_api" "default" {
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = var.graphql_api_name
  schema              = var.graphql_schema

  user_pool_config {
    default_action = "DENY"
    user_pool_id   = var.cognito_user_pool_id
  }
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

