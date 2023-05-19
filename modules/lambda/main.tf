resource "aws_lambda_function" "this" {
  
  filename      = var.lambda_info.filename
  function_name = var.lambda_info.function_name
  role          = "arn:aws:iam::${var.account_id}:role/LabRole"
  handler       = var.lambda_info.handler
  runtime       = var.lambda_info.runtime

  tags = {
    name = "Lambda ${var.lambda_info.function_name}"
  }
  lifecycle {
    create_before_destroy = true
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.sg_ids
  }

}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${var.apigw_execution_arn}/*"
}


resource "aws_api_gateway_resource" "resource" {
  path_part   =  var.lambda_info.part_path
  parent_id   =  var.apigw_resource_id
  rest_api_id =  var.apigw_id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   =   var.apigw_id
  resource_id   =  aws_api_gateway_resource.resource.id
  http_method   = var.lambda_info.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             =  var.apigw_id
  resource_id             =  aws_api_gateway_resource.resource.id
  http_method             =  aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     =  aws_lambda_function.this.invoke_arn
}
