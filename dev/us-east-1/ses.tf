resource "aws_ses_domain_identity" "onguard_co" {
  domain = "onguard.co"
}
resource "aws_ses_email_identity" "hello_onguard_co" {
  email = "hello@onguard.co"
}
