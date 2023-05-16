locals {
  # VPC LOCALS
  vpc_cidr = "10.0.0.0/16"


  # LAMBDAS
  path = "../resources"
  lambdas = {
    "get_pets" = {
      filename = "${local.path}/lambda/lambda_get_pets.zip"
      function_name = "getPets"
      method = "GET"
      handler = "lambda_get_list_pets.main"
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
}