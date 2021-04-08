resource "aws_lambda_layer_version" "pymysql_layer" {
  filename   = "../../assets/lambda_layer/pymysql.zip"
  layer_name = "pymysql-layer"

  compatible_runtimes = ["python3.8"]
}


resource "aws_lambda_layer_version" "stripe_layer" {
  filename   = "../../assets/lambda_layer/stripe.zip"
  layer_name = "stripe-layer"

  compatible_runtimes = ["python3.8"]
}