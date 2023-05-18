locals {
  public_subnets = [cidrsubnet(aws_vpc.this.cidr_block, 8, 1), cidrsubnet(aws_vpc.this.cidr_block, 8, 2)]
  availability_zones = ["us-east-1a", "us-east-1b"]
  names = ["pub1", "pub2"]
}