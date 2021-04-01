data "aws_ssm_parameter" "api_db_server_uri" {
  name = aws_ssm_parameter.api_db_database_uri.name
}

module "cognito_presignup_trigger" {
  source = "../../modules/lambda_function"

  function_name = "cognito_presignup_trigger"
  role_arn      = module.presignup_lambda_role.role_arn
  handler       = "main.lambda_handler"
  

  runtime = "python3.8"

}

resource "aws_lambda_permission" "cognito_permission" {
  statement_id  = "AllowExecutionCognito"
  action        = "lambda:InvokeFunction"
  function_name = module.cognito_presignup_trigger.arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.default.arn
}


module "cognito_postsignup_trigger" {
  source = "../../modules/lambda_function"

  function_name = "cognito_postsignup_trigger"
  role_arn      = module.postsignup_lambda_role.role_arn
  handler       = "main.lambda_handler"
  vpc_subnet_ids         = [aws_subnet.public1.id, aws_subnet.public2.id]
  vpc_security_group_ids = [aws_security_group.lambda.id]
  lambda_layer_arns = [aws_lambda_layer_version.pymysql_layer.arn]
  runtime = "python3.8"
  timeout = 30
  # dont use in prod.. use ssm
  variables     = {
                      DATABASE_URI = data.aws_ssm_parameter.api_db_server_uri.value
                    }



}

resource "aws_lambda_permission" "cognito_postsignup_permission" {
  statement_id  = "AllowExecutionCognito"
  action        = "lambda:InvokeFunction"
  function_name = module.cognito_postsignup_trigger.arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.default.arn
}