module "site_bucket" {

  # TODO Funciona pero habría que ver si necesitamos algún parámetro más

  source = "terraform-aws-modules/s3-bucket/aws"

  bucket_prefix = local.site_bucket.prefix

  versioning = {
    enabled = true
  }

  # TODO Estas dos entradas se necesitan?
  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  attach_policy = true
  policy        = data.aws_iam_policy_document.site.json

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }

}

resource "aws_s3_object" "data" {
  for_each = { for file in local.file_with_type : "${file.file_name}.${file.mime}" => file }

  bucket       = module.site_bucket.s3_bucket_id
  key          = each.value.file_name
  
  source       = "../resources/web/${each.value.file_name}"
  etag         = filemd5("../resources/web/${each.value.file_name}")
  content_type = each.value.mime
}


