resource "aws_apigatewayv2_api" "checkin_api_gateway" {
  name                       = "checkin-gateway"
  protocol_type              = "HTTP"

  cors_configuration  {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }


}
resource "aws_apigatewayv2_route" "checkin_api_route" {
  api_id    = aws_apigatewayv2_api.checkin_api_gateway.id
  route_key = "$default"
  target = "integrations/${aws_apigatewayv2_integration.checkin_api_gateway.id}"
}
resource "aws_apigatewayv2_integration" "checkin_api_gateway" {
  api_id           = aws_apigatewayv2_api.checkin_api_gateway.id
  integration_type = "AWS_PROXY"

  connection_type           = "INTERNET"
  content_handling_strategy = "CONVERT_TO_TEXT"
  integration_method        = "POST"
  integration_uri           = module.check_in_consumer.invoke_arn
}
resource "aws_apigatewayv2_authorizer" "checkin_gateway_authorizer" {
  api_id           = aws_apigatewayv2_api.checkin_api_gateway.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "checkin_authorizer"

  jwt_configuration {
    #   client app id
    audience = [module.mobile_app_client.appclient_id, module.web_app_client.appclient_id]
    # endpoint
    issuer   = "https://${aws_cognito_user_pool.default.endpoint}"
  }
}
# stage deploy
resource "aws_apigatewayv2_stage" "checkin_stage" {
  api_id      = aws_apigatewayv2_api.checkin_api_gateway.id
  name        = "live"
}
# role to write to cloudwatch
resource "aws_api_gateway_account" "checkin_account" {
  cloudwatch_role_arn = module.checkin_gateway_role.role_arn
  depends_on = [module.checkin_gateway_role ]
}
# Permission
resource "aws_lambda_permission" "apigw" {
	action        = "lambda:InvokeFunction"
	function_name = module.check_in_consumer.arn
	principal     = "apigateway.amazonaws.com"

	source_arn = "${aws_apigatewayv2_api.checkin_api_gateway.execution_arn}/*/*"
}