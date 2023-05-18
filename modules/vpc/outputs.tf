output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value = aws_vpc.this.cidr_block
}

output "subnet_ids" {
  description = "The list of subnets created"
  value       = [for subnet in aws_subnet.this : subnet.id]
}