resource "aws_acm_certificate" "cert" {
  provider = aws.everything
  domain_name               = "mofostaging.net"
  subject_alternative_names = ["homepage-refresh-cdn.mofostaging.net"]
  validation_method         = "DNS"

  tags = local.tags
}

resource "aws_acm_certificate_validation" "validation" {
  provider = aws.everything
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
    aws_route53_record.cert_validation_alt1.fqdn
  ]
}
