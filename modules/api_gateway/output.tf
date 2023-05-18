output "domain_name" {
  description = "API Gateway Domain Name"
  value       = join(".", [aws_api_gateway_rest_api.this.id, "execute-api", var.aws_region_name, "amazonaws.com"])
}

output "id" {
  description = "API Gateway ID"
  value       = aws_api_gateway_rest_api.this.id
}

output "execution_arn" {
  description = "apigw_execution_arn"
  value = aws_api_gateway_rest_api.this.execution_arn
}