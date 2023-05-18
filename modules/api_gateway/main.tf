resource "aws_api_gateway_rest_api" "this" {
  name = var.name
  description = var.description
  body = data.template_file.apigw-openapi.rendered
}

data "template_file" "apigw-openapi" {
  template = var.template_file
  vars = var.template_file_vars
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.this.body))
  }


}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "prod_stage"
}