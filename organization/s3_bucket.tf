module "site_bucket" {

  # TODO Funciona pero habría que ver si necesitamos algún parámetro más

  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.site_bucket.name

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

resource "aws_s3_object" "main-index" {
  bucket = module.site_bucket.s3_bucket_id
  key    = "index.html"
  source = "../resources/web/index.html"
}

resource "aws_s3_object" "main-error" {
  bucket = module.site_bucket.s3_bucket_id
  key    = "error.html"
  source = "../resources/web/error.html"
}

