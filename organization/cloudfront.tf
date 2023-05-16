module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"


  #  Extra CNAMEs (alternate domain names), if any, for this distribution.
  aliases = []

  #  Any comments you want to include about the distribution.
  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true

  #  The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100
  # TODO Ver que son estas clases. Y cual usar.
  price_class         = "PriceClass_All"

  retain_on_delete    = false
  wait_for_deployment = false

  #  Controls if CloudFront origin access identity should be created
  # TODO Origin access
  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }

  #  The logging configuration that controls how logs are written to your distribution (maximum one).
  # TODO Setup logs bucket
  logging_config = {
    bucket = "logs-my-cdn.s3.amazonaws.com"
  }

  #  One or more origins for this distribution (multiples allowed).
  origin = {
    api = {
      domain_name = module.apigw.domain_name
      origin_id = module.apigw.id



    }
    something = {
      domain_name = "something.example.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    s3_one = {
      domain_name = "my-s3-bycket.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  #  The default cache behavior for this distribution
  default_cache_behavior = {
    target_origin_id           = "something"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/static/*"
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]

  viewer_certificate = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
    ssl_support_method  = "sni-only"
  }
}