# VPC definitions
resource "aws_default_vpc" "default" {
  
  tags = {
    Name = "Default VPC"
  }
}

#  Subnet definitions
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.0.0/20"

  tags = {
    Service = "ELB"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.16.0/20"

  tags = {
    Service = "ELB"
  }
}
resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.32.0/20"

  tags = {
    Service = "webserver"
  }
}
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.48.0/20"

  tags = {
    Service = "webserver"
  }
}

resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.54.0/20"

  tags = {
    Service = "db"
  }
}

resource "aws_subnet" "private4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "172.31.70.0/20"

  tags = {
    Service = "db"
  }
}

# subnet routetable association

resource "aws_route_table_association" "public_sub_associate_1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_default_route_table.default_route_table.id
}

resource "aws_route_table_association" "public_sub_associate_2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_default_route_table.default_route_table.id
}

# Route Table Definitions
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = "rtb-72adf30c"

  tags = {
    Name = "default table"
  }
}
