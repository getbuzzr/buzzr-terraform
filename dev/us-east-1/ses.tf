resource "aws_ses_domain_identity" "getbuzzr_co" {
  domain = "getbuzzr.co"
}
resource "aws_ses_email_identity" "hello_buzzr_co" {
  email = "hello@getbuzzr.co"
}
