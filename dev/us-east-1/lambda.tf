resource "aws_lambda_function" "cognito_presignup_trigger" {
  function_name = "cognito_presignup_trigger"
  role          = module.presignup_lambda_role.role_arn
  handler       = "lambda_function.lambda_handler"


  runtime = "python.3.8"

  environment {
    variables = {
      service = "login"
    }
  }
}
