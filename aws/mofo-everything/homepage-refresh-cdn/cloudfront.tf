data "aws_s3_bucket" "mofo_assets_staging" {
  bucket = "mofo-assets-staging"
}

resource "aws_cloudfront_distribution" "distribution" {
  provider = aws.everything
  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["homepage-refresh-cdn.mofostaging.net"]
  price_class     = "PriceClass_All"
  tags            = local.tags

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    default_ttl            = 3600

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }
  }

  ordered_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    path_pattern = "static/*"
    target_origin_id = "homepage-refresh-origin"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      headers      = ["Origin"]
      cookies {
        forward = "none"
      }
    }
  }

  origin {
    domain_name = data.aws_s3_bucket.mofo_assets_staging.website_endpoint
    origin_id   = local.s3_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  origin {
    domain_name = "homepage-refresh.mofostaging.net"
    origin_id   = "homepage-refresh-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

