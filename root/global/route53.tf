resource "aws_route53_zone" "onguard_co" {
  name = "onguard.co"
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "onguard.co"
  type    = "A"
  ttl     = "300"

  records = ["35.206.71.68"]

}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "www.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["onguard.co"]

}

resource "aws_route53_record" "staging1" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "staging1.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["onguard.co"]

}

resource "aws_route53_record" "www_staging1" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "www.staging1.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["onguard.co"]

}

resource "aws_route53_record" "blog" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "blog.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["6145128.group28.sites.hubspot.net"]

}

resource "aws_route53_record" "demo" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "demo.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["demo.onguard.co.s3-website-us-west-2.amazonaws.com"]

}

resource "aws_route53_record" "info" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "info.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["6145128.group28.sites.hubspot.net"]

}

resource "aws_route53_record" "mail" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "mail.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["6145128.group28.sites.hubspot.net"]

}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "onguard.co"
  type    = "MX"
  ttl     = "300"

  records = [
    "1 aspmx.l.google.com",
    "5 alt2.aspmx.l.google.com",
    "5 alt1.aspmx.l.google.com",
    "10 alt3.aspmx.l.google.com",
    "10 alt4.aspmx.l.google.com",
  ]

}

resource "aws_route53_record" "txt" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "onguard.co"
  type    = "TXT"
  ttl     = "300"

  records = ["google-site-verification=B-6oDsjQFX3IJJMF13set-Lwo4ceq19h7qHxt7mrCa4"]

}

resource "aws_route53_record" "_d22fbc1b11c72e165b73d29468da79c0" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "_d22fbc1b11c72e165b73d29468da79c0.oauth.onguard.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_45d5fd035b7ff160e4a78c730371e8a0.rlltrpyzyf.acm-validations.aws"]

}

