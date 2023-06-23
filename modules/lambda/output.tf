output "invoke_arn" {
  description = "CIDR block of the VPC"
  value       = aws_lambda_function.this.invoke_arn
}