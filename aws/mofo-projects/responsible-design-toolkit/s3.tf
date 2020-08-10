resource "aws_s3_bucket" "bucket" {
  bucket = "responsible-design.org-static"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 86400
  }

  tags = local.tags
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "AllowCloudFrontAccessIdentity",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.oai.iam_arn}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.bucket.arn}/*"
        }
    ]
}
POLICY
}

locals {
  content_type_map = {
    html        = "text/html",
    js          = "application/javascript",
    css         = "text/css",
    svg         = "image/svg+xml",
    jpg         = "image/jpeg",
    png         = "image/png",
    gif         = "image/gif",
    ico         = "image/x-icon",
    map         = "application/json",
    pdf         = "application/pdf",
    webmanifest = "application/manifest+json",
    txt         = "text/plain"
  }
}

resource "aws_s3_bucket_object" "src_files" {
  # Enumerate all the files in ./src
  for_each = fileset(local.src_dir, "**")

  # Create an object from each
  bucket        = aws_s3_bucket.bucket.id
  key           = replace(each.value, local.src_dir, "")
  source        = "${local.src_dir}/${each.value}"
  acl           = "private"
  cache_control = "max-age=86400"
  etag          = filemd5("${local.src_dir}/${each.value}")
  content_type  = lookup(local.content_type_map, regex("\\.(?P<extension>[A-Za-z0-9]+)$", each.value).extension, "application/octet-stream")
  tags          = local.tags
}
