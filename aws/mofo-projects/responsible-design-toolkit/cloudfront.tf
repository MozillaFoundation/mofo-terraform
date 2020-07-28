resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Access identity for the Responsible Design Toolkit cloudfront distribution"
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id


    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http2"
  comment             = "Responsible Design Toolkit Cloudfront Distribution"
  default_root_object = "index.html"

//  aliases = ["openbadgespec.org", "www.openbadgespec.org"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = local.tags

  viewer_certificate {
    cloudfront_default_certificate = true
//    acm_certificate_arn = aws_acm_certificate.cert.arn
//    ssl_support_method  = "sni-only"
  }

}