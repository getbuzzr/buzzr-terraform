module "cognito_presignup_trigger" {
  source = "../../modules/lambda_function"

  function_name = "cognito_presignup_trigger"
  role_arn      = module.presignup_lambda_role.role_arn
  handler       = "main.lambda_handler"


  runtime = "python3.8"

  environment {
    variables = {
      service = "login"
    }
  }
}
