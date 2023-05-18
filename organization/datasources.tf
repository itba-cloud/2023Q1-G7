data "aws_caller_identity" "current" {
  provider = aws.aws
}

data "aws_region" "current" {
  provider = aws.aws
}

data "aws_iam_policy_document" "site" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.site_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "AWS"
      identifiers = module.cdn.cloudfront_origin_access_identity_iam_arns
    }
  }
}
