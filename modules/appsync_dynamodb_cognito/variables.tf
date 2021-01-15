variable "graphql_api_name" {
  type        = string
  description = "The GraphQL API name."
}

variable "dynamodb_service_role_arn" {
  type        = string
  description = "The IAM service role ARN for the DynamoDB data source."
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table."
}

variable "cognito_user_pool_id" {
  type        = string
  description = "The user pool ID."
}

variable "graphql_schema" {
  type        = string
  description = "The GraphQL schema definition."
}

variable "cloudwatch_logs_role_arn" {
  type        = string
  description = "The ARN of the CloudWatch logs role."
}