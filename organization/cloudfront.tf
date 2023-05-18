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
  create_origin_access_identity = true
  origin_access_identities = {
    frontend_s3_bucket = "My awesome CloudFront can access"
  }

  #  The logging configuration that controls how logs are written to your distribution (maximum one).
  # TODO Setup logs bucket
#  logging_config = {
#    bucket = "logs-my-cdn.s3.amazonaws.com"
#  }

  #  One or more origins for this distribution (multiples allowed).
  origin = {
    api = {
      domain_name = module.apigw.domain_name
      origin_id = module.apigw.id

      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }

    }

    frontend = {
      domain_name = module.site_bucket.s3_bucket_bucket_domain_name
      origin_id = module.site_bucket.s3_bucket_id
      s3_origin_config = {
        origin_access_identity = "frontend_s3_bucket"
      }
    }

  }

  default_root_object = "index.html"

  #  The default cache behavior for this distribution
  default_cache_behavior = {
    target_origin_id           = module.site_bucket.s3_bucket_id
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

  }

  ordered_cache_behavior = [
    {
      path_pattern           = "prod_stage/api/*"
      target_origin_id       = module.apigw.id
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "PUT", "PATCH", "POST"]
      cached_methods  = ["GET", "HEAD"]

      compress        = true
      query_string    = true

      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
    }
  ]

  viewer_certificate = {
    cloudfront_default_certificate = true
  }
}