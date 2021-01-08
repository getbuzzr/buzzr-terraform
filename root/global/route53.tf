locals {
  cloudfront_distribution_hosted_zone_id = "Z2FDTNDATAQYW2"
}

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

resource "aws_route53_record" "oauth_onguard_co" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "oauth.onguard.co"
  type    = "A"
  
  alias {
    name                   = "d3lhv8oss31uqp.cloudfront.net"
    zone_id                = local.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "_607a1f42abe08756d62cd03e15038297" {
  zone_id  = aws_route53_zone.onguard_co.zone_id
  name     = "_607a1f42abe08756d62cd03e15038297.dev.auth.onguard.co"
  type     = "CNAME"
  ttl      = "300"

  records = ["_8d867ad30202cb434dd73a4fa57906dc.rlltrpyzyf.acm-validations.aws"]
}

resource "aws_route53_record" "_4c900915875458c78063480f9d33b222" {
  zone_id  = aws_route53_zone.onguard_co.zone_id
  name     = "_83d270a800dd5a0d69550a9cd07126a7.staging.auth.onguard.co"
  type     = "CNAME"
  ttl      = "300"

  records = ["_e58a07dc88b095407e65a5892a2a4933.rlltrpyzyf.acm-validations.aws"]
}

resource "aws_route53_record" "_c716b082791e6ff24078ca860aeba8b2" {
  zone_id  = aws_route53_zone.onguard_co.zone_id
  name     = "_c716b082791e6ff24078ca860aeba8b2.auth.onguard.co"
  type     = "CNAME"
  ttl      = "300"

  records = ["_11cefd25bf0664a9ef45e7dcc11efb31.rlltrpyzyf.acm-validations.aws"]
}

resource "aws_route53_record" "auth_onguard_co" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "auth.onguard.co"
  type    = "A"
  ttl     = "300"

  ## Placeholder
  records = ["127.0.0.1"]
}

resource "aws_route53_record" "dev_auth_onguard_co" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "dev.auth.onguard.co"
  type    = "A"

  alias {
    name                   = "d3vj1yyciumcm9.cloudfront.net"
    zone_id                = local.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "_6a3d953604e3c871511825d55c5afe99" {
  zone_id  = aws_route53_zone.onguard_co.zone_id
  name     = "_6a3d953604e3c871511825d55c5afe99.dev.api.onguard.co"
  type     = "CNAME"
  ttl      = "300"

  records = ["_f2fe44e5e3f18df21511f1172b58f199.rlltrpyzyf.acm-validations.aws"]
}

esource "aws_route53_record" "dev_api_onguard_co" {
  zone_id = aws_route53_zone.onguard_co.zone_id
  name    = "dev.api.onguard.co"
  type    = "A"

  alias {
    name                   = "onguard-dev-env.eba-2qhpgzjy.us-east-1.elasticbeanstalk.com"
    evaluate_target_health = true
  }
}