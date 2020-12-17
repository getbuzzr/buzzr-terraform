module "appsync_checkin" {
  source                    = "../../modules/appsync_dynamodb_cognito"
  cognito_user_pool_id      = aws_cognito_user_pool.default.id
  dynamodb_table_name       = aws_dynamodb_table.checkin.name
  dynamodb_service_role_arn = module.appsync_dynamodb_data_source_role.role_arn
  graphql_schema            = file("appsync_checkin_files/schema.graphql")
  graphql_api_name          = aws_dynamodb_table.checkin.name
}

resource "aws_appsync_resolver" "mutation_create_checkin" {
  type              = "Mutation"
  field             = "createCheckInStatus"
  api_id            = module.appsync_checkin.graphql_api_id
  data_source       = module.appsync_checkin.dynamodb_data_source.name
  request_template  = file("appsync_checkin_files/create_checkin_resolver_request_template.vm")
  response_template = "$util.toJson($context.result)"
}

resource "aws_appsync_resolver" "mutation_update_checkin" {
  type              = "Mutation"
  field             = "updateCheckInStatus"
  api_id            = module.appsync_checkin.graphql_api_id
  data_source       = module.appsync_checkin.dynamodb_data_source.name
  request_template  = file("appsync_checkin_files/update_checkin_resolver_request_template.vm")
  response_template = "$util.tojson($context.result)"
}

resource "aws_appsync_resolver" "mutation_delete_checkin" {
  type              = "Mutation"
  field             = "deleteCheckInStatus"
  api_id            = module.appsync_checkin.graphql_api_id
  data_source       = module.appsync_checkin.dynamodb_data_source.name
  request_template  = file("appsync_checkin_files/delete_checkin_resolver_request_template.vm")
  response_template = "$util.tojson($context.result)"
}
