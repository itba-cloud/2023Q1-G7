module "site_bucket" {

  source = "terraform-aws-modules/s3-bucket/aws"

  bucket_prefix = local.buckets.site_bucket.prefix

  versioning = {
    enabled = true
  }

  attach_policy = true
  policy        = data.aws_iam_policy_document.site.json

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging = {
    target_bucket = module.logs-bucket["site"].s3_bucket_id
    target_prefix = local.buckets.logs_prefix
  }

  server_side_encryption_configuration = local.buckets.default_server_side_encryption

}

module "logs-bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  for_each = local.buckets.logs_bucket.prefixes

  versioning = {
    enabled = true
  }

  bucket_prefix = each.value
  acl           = "log-delivery-write"

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  server_side_encryption_configuration = local.buckets.default_server_side_encryption

  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true
  force_destroy                         = true

  lifecycle_rule = [
    {
      id = "log"

      expiration = {
        days = 90
      }

      filter = {
        and = {
          prefix = "log/"

          tags = {
            rule      = "log"
            autoclean = "true"
          }
        }
      }

      status = "Enabled"

      transition = {
        days          = 30
        storage_class = "STANDARD_IA"
      }

      transition = {
        days          = 60
        storage_class = "GLACIER"
      }
    }
  ]

}

resource "aws_s3_object" "data" {
  for_each = { for file in local.file_with_type : "${file.file_name}.${file.mime}" => file }

  bucket = module.site_bucket.s3_bucket_id
  key    = each.value.file_name

  source       = "../resources/web/${each.value.file_name}"
  etag         = filemd5("../resources/web/${each.value.file_name}")
  content_type = each.value.mime
}


