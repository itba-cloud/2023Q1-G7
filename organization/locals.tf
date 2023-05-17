locals {
  # VPC LOCALS
  vpc_cidr = "10.0.0.0/16"


  # LAMBDAS
  path = "../resources"
  lambdas = {
    "get_pets" = {
      filename = "${local.path}/lambda/lambda_get_pets.zip"
      function_name = "get_pets"
      method = "GET"
      handler = "lambda_get_pets.main"
      path = "/pets"
      part_path = "pets" 
      # TODO: no se que son estos ultimos 3
    },
    "post_pet" = {
      filename = "${local.path}/lambda/lambda_post_pet.zip"
      function_name = "post_pet"
      method = "POST"
      handler = "lambda_post_pet.main"
      path = "/pets"
      part_path = "pets" 
      # TODO: no se que son estos ultimos 3
    }
  }

  # API GW
  apigw = {
    name = "main_api_gw",
    description = "Main API gateway",
  }

  # Site bucket
  site_bucket = {
    name = "adoptemos-todos-s3",

  }

}