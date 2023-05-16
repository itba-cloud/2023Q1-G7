module "apigw" {
  source = "../modules/api_gateway"

  providers = {
    aws = aws.aws
  }
  name = local.apigw.name
  description = local.apigw.description
  aws_region_name = data.aws_region.current.name
  account_id = data.aws_caller_identity.current.account_id
  template_file_vars = "algo del openAPI"
  template_file = jsonencode({
    openapi = "3.0.1",
    info = {
      title = local.apigw.name
      version = "1.0.0"
    }
    paths = {
      "/hello" = {
        get = {
          x-amazon-apigateway-integration = {
            uri = module.lambda["get-pets"].invoke_arn
            httpMethod = "POST"
            type = "aws_proxy"
          }
        }
      }
    }

  })
}