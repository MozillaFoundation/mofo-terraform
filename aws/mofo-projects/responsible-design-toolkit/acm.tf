resource "aws_acm_certificate" "cert" {
  domain_name               = "responsibledesign.tech"
  subject_alternative_names = ["www.responsibledesign.tech"]
  validation_method         = "DNS"
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
    aws_route53_record.cert_validation_alt1.fqdn
  ]
}
