module "site_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  force_destroy = true
  bucket        = local.bucket_name

  # Bucket policies
  attach_policy = true
  policy        = data.aws_iam_policy_document.site.json
  # attach_deny_insecure_transport_policy = true
  # attach_require_latest_tls_policy      = true

  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  acl = "private" # "acl" conflicts with "grant" and "owner"

  versioning = {
    status     = true
    mfa_delete = false
  }

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }


  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}


