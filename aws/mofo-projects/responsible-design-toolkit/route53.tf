resource "aws_route53_zone" "primary" {
  name = "responsibledesign.tech"
  tags = local.tags
}

resource "aws_route53_record" "primary-a" {
  name = "responsibledesign.tech"
  type = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
  }
}

resource "aws_route53_record" "primary-aaaa" {
  name = "responsibledesign.tech"
  type = "AAAA"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
  }
}

resource "aws_route53_record" "primary-www-a" {
  name = "www.responsibledesign.tech"
  type = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
  }
}

resource "aws_route53_record" "primary-www-aaaa" {
  name = "www.responsibledesign.tech"
  type = "AAAA"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
  }
}

resource "aws_route53_record" "cert_validation" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  zone_id = aws_route53_zone.primary.zone_id
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_alt1" {
  name    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_type
  records = [aws_acm_certificate.cert.domain_validation_options.1.resource_record_value]
  zone_id = aws_route53_zone.primary.zone_id
  ttl     = 60
}