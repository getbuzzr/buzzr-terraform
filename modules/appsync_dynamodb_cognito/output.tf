output "graphql_api_id" {
  value = aws_appsync_graphql_api.default.id
}

output "dynamodb_data_source" {
  value = aws_appsync_datasource.dynamodb
}
output "graphql_api_url" {
  value = aws_appsync_graphql_api.default.uris.GRAPHQL
}