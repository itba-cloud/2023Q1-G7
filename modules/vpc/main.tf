resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC"
  }
}


resource "aws_subnet" "this" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.this.id
  availability_zone = local.availability_zones[count.index]
  cidr_block        = local.private_subnets[count.index]

  tags = {
    Name = local.names[count.index]
  }

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table_association" "private" {
  count          = length(local.private_subnets)
  subnet_id      = aws_subnet.this[count.index].id
  route_table_id = aws_route_table.private.id
}
