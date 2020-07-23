resource "aws_s3_bucket" "bucket" {
  bucket = "openbadgespec.org-static"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3600
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

resource "aws_s3_bucket_object" "static_files" {
  # Enumerate all the JSON files in ./staticfiles
  for_each = fileset(local.staticfiles_dir, "**")

  # Create an object from each
  bucket       = aws_s3_bucket.bucket.id
  key          = replace(each.value, local.staticfiles_dir, "")
  source       = "./${local.staticfiles_dir}/${each.value}"
  acl          = "private"
  etag         = filemd5("./${local.staticfiles_dir}/${each.value}")
  content_type = "application/json"
  tags         = local.tags
}
