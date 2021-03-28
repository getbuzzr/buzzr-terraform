locals {
  cloudfront_distribution_hosted_zone_id = "Z2FDTNDATAQYW2"
}

resource "aws_route53_zone" "getbuzzr_co" {
  name = "getbuzzr.co"
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "getbuzzr.co"
  type    = "A"
  ttl     = "300"

  records = [""]

}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "www.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["getbuzzr.co"]

}


resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "getbuzzr.co"
  type    = "MX"
  ttl     = "300"

  records = [
    "1 aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "5 alt1.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com",
    "15 dc24yumuxqy37tph32li2nlxhcxqrvrzourdm7fksqzizztraw2q.mx-verification.google.com."
  ]
}
