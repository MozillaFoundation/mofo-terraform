resource "aws_route53_zone" "primary" {
  name = "responsibledesign.tech"
  tags = local.tags
}