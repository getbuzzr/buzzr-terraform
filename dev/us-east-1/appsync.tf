module "appsync_checkin" {
  source                    = "../../modules/appsync_dynamodb_cognito"
  cognito_user_pool_id      = aws_cognito_user_pool.default.id
  dynamodb_table_name       = aws_dynamodb_table.checkin.name
  dynamodb_service_role_arn = module.appsync_dynamodb_data_source_role.role_arn
  graphql_schema            = file("../../assets/appsync_checkin/schema.graphql")
  graphql_api_name          = aws_dynamodb_table.checkin.name
  cloudwatch_logs_role_arn  = module.appsync_cloudwatch_logs_role.role_arn
}

resource "aws_appsync_resolver" "query_get_checkin_status" {
  type              = "Query"
  field             = "getCheckinStatus"
  api_id            = module.appsync_checkin.graphql_api_id
  data_source       = module.appsync_checkin.dynamodb_data_source.name
  request_template  = file("../../assets/appsync_checkin/get_checkin_status_resolver_request_template.vm")
  response_template = "$util.toJson($context.result)"
}

resource "aws_appsync_resolver" "query_get_checkin_statuses_for_group" {
  type              = "Query"
  field             = "getCheckinStatusesForGroup"
  api_id            = module.appsync_checkin.graphql_api_id
  data_source       = module.appsync_checkin.dynamodb_data_source.name
  request_template  = file("../../assets/appsync_checkin/get_checkin_statuses_for_group_resolver_request_template.vm")
  response_template = "$util.toJson($context.result)"
}