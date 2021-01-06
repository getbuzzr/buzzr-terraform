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

module "check_in_consumer" {
  source = "../../modules/lambda_function"

  function_name = "check_in_consumer"
  role_arn      = module.checkin_consumer_lambda_role.role_arn
  handler       = "main.lambda_handler"


  runtime = "python3.8"

}


module "expiry_trigger" {
  source = "../../modules/lambda_function"

  function_name = "expiry_trigger"
  role_arn      = module.expiry_trigger_lambda_role.role_arn
  handler       = "main.lambda_handler"
  vpc_subnet_ids         = [aws_subnet.private1.id, aws_subnet.private2.id]
  vpc_security_group_ids = [aws_security_group.web_server.id]

  runtime = "python3.8"

}


module "cognito_postsignup_trigger" {
  source = "../../modules/lambda_function"

  function_name = "cognito_postsignup_trigger"
  role_arn      = module.postsignup_lambda_role.role_arn
  handler       = "main.lambda_handler"
  vpc_subnet_ids         = [aws_subnet.private1.id, aws_subnet.private2.id]
  vpc_security_group_ids = [aws_security_group.web_server.id]
  lambda_layer_arns = [aws_lambda_layer_version.pymysql_layer.arn]
  runtime = "python3.8"

}

resource "aws_lambda_permission" "cognito_postsignup_permission" {
  statement_id  = "AllowExecutionCognito"
  action        = "lambda:InvokeFunction"
  function_name = module.cognito_postsignup_trigger.arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.default.arn
}