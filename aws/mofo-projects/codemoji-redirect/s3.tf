resource "aws_s3_bucket" "bucket" {
  bucket = "codemoji-org-redirect"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Redirect": {
      "HostName" : "foundation.mozilla.org",
      "HttpRedirectCode" : "307",
      "Protocol" : "https",
      "ReplaceKeyWith" : "campaigns/codemoji?utm_source=codemoji.org&utm_content=redirect"
    }
}]
EOF
  }

  tags = local.tags
}
