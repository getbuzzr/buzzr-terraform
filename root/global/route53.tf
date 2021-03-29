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

resource "aws_route53_record" "_5a62dcc99fdb7bc88e89c1b3f19bec43_dev_auth_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_5a62dcc99fdb7bc88e89c1b3f19bec43.dev.auth.getbuzzr.co."
  type    = "CNAME"
  ttl     = "300"

  records = ["_c9f0ee0c45de74155a2c24562c1b6f32.zjfbrrwmzc.acm-validations.aws."]

}

resource "aws_route53_record" "_20eb31147bc107e653144f29e42171f2_dev_api_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_20eb31147bc107e653144f29e42171f2.dev.api.getbuzzr.co."
  type    = "CNAME"
  ttl     = "300"

  records = ["_db2740a4895a80269d93ecf939821520.zjfbrrwmzc.acm-validations.aws."]

}

resource "aws_route53_record" "_a3cdea48dc60141142f994b54859a844_dev_admin_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_a3cdea48dc60141142f994b54859a844.dev.admin.getbuzzr.co."
  type    = "CNAME"
  ttl     = "300"

  records = ["_ea5cfa5c3c5a0a13734fc35ca886ea1c.zjfbrrwmzc.acm-validations.aws."]

}

resource "aws_route53_record" "_2ff33e99df695acfb52ea328f2a3d50d_dev_static_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_2ff33e99df695acfb52ea328f2a3d50d.dev.static.getbuzzr.co."
  type    = "CNAME"
  ttl     = "300"

  records = ["_35a8e928dbe531b446217885e0730ae3.zjfbrrwmzc.acm-validations.aws."]

}