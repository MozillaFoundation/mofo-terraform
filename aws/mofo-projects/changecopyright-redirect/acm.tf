resource "aws_acm_certificate" "cert" {
  domain_name               = "changecopyright.org"
  subject_alternative_names = ["www.changecopyright.org"]
  validation_method         = "DNS"

  tags = local.tags
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
    aws_route53_record.cert_validation_alt1.fqdn
  ]
}
