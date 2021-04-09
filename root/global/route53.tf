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

  records = ["192.168.0.0"]

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
  name    = "_5a62dcc99fdb7bc88e89c1b3f19bec43.dev.auth.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_c9f0ee0c45de74155a2c24562c1b6f32.zjfbrrwmzc.acm-validations.aws"]

}

resource "aws_route53_record" "_20eb31147bc107e653144f29e42171f2_dev_api_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_20eb31147bc107e653144f29e42171f2.dev.api.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_db2740a4895a80269d93ecf939821520.zjfbrrwmzc.acm-validations.aws"]

}

resource "aws_route53_record" "_a3cdea48dc60141142f994b54859a844_dev_admin_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_a3cdea48dc60141142f994b54859a844.dev.admin.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_ea5cfa5c3c5a0a13734fc35ca886ea1c.zjfbrrwmzc.acm-validations.aws"]

}

resource "aws_route53_record" "_2ff33e99df695acfb52ea328f2a3d50d_dev_static_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_2ff33e99df695acfb52ea328f2a3d50d.dev.static.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_35a8e928dbe531b446217885e0730ae3.zjfbrrwmzc.acm-validations.aws"]

}

resource "aws_route53_record" "_3a56e530db63ec02ce7dec53c210ac22_oauth_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_3a56e530db63ec02ce7dec53c210ac22.oauth.getbuzzr.co"
  type    = "CNAME"
  ttl     = "300"

  records = ["_61ce4b20b33f8626f101fa4cae15d4ef.zjfbrrwmzc.acm-validations.aws"]

}

resource "aws_route53_record" "auth_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "auth.getbuzzr.co"
  type    = "A"
  ttl     = "300"

  ## Placeholder
  records = ["127.0.0.1"]
}

resource "aws_route53_record" "dev_auth_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "dev.auth.getbuzzr.co"
  type    = "A"

  alias {
    name                   = "dlpdmbxc8jqgb.cloudfront.net"
    zone_id                = local.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dev_api_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "dev.api.getbuzzr.co"
  type    = "A"

  alias {
    name                   = "buzzr-dev-env.eba-pkqmcmcr.us-east-1.elasticbeanstalk.com"
    evaluate_target_health = true
    zone_id                = "Z117KPS5GTRQ2G"
  }
}

resource "aws_route53_record" "ses_domain_txt_verification" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "_amazonses.getbuzzr.co"
  type    = "TXT"
  ttl     = "600"
  records = ["kWV4Tp+f9TBPvK3DwwFzSAVHCm3vS7dUkXGTL2EvfNQ="]
}

resource "aws_route53_record" "oauth_getbuzzr_co" {
  zone_id = aws_route53_zone.getbuzzr_co.zone_id
  name    = "oauth.getbuzzr.co"
  type    = "A"

  alias {
    name                   = "d3g9kpkdr1ry52.cloudfront.net"
    zone_id                = local.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}