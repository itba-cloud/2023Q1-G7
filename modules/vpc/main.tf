resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "internet_gw"
  }
}

resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress{
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  egress{
    protocol = -1
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }
}

resource "aws_subnet" "this" {
  count = length(local.public_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = local.availability_zones[count.index]
  # TODO public?
  cidr_block        = local.public_subnets[count.index]

  tags = {
    Name = local.names[count.index]
  }


  # vpc_id = aws_vpc.mainvpc.id
  # availability_zone = "us-east-1a"
  # cidr_block = "10.0.1.0/24"
  # # la az y cidr deberian ser local/vars
  # tags = {
  #   Name = "pub1"
  # }
}

# resource "aws_subnet" "this" {
#   vpc_id = aws_vpc.mainvpc.id
#   availability_zone = "us-east-1b"
#   cidr_block = "10.0.2.0/24"
  
#   tags = {
#     Name = "pub2"
#   }
# }