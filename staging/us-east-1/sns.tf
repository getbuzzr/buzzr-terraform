resource "aws_sns_platform_application" "gcm_application" {
  name                = "gcm_application"
  platform            = "GCM"
  platform_credential = aws_ssm_parameter.gcm_api_key.value
}

resource "aws_sns_platform_application" "apns_application" {
  name = "apns_application"
  # user "APNS" for prod
  platform                     = "APNS_SANDBOX"
  platform_credential          = aws_ssm_parameter.apns_private_key.value
  platform_principal           = aws_ssm_parameter.apns_certificate.value
  success_feedback_sample_rate = 100
}
