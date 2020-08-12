resource "aws_s3_bucket" "bucket" {
  bucket = "changecopyright-org-redirect"
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
      "ReplaceKeyWith" : "artifacts/change-copyright?utm_source=changecopyright.org&utm_content=redirect"
    }
}]
EOF
  }

  tags = local.tags
}
