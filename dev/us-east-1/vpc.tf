# VPC definitions
resource "aws_default_vpc" "default" {

  tags = {
    Name = "Default VPC"
  }
}

#  Subnet definitions
resource "aws_subnet" "nat_gateway_subnet" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.6.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "nat_gateway_subnet"
    Service = "NAT Gateway"
    type    = "public"
  }
}
resource "aws_subnet" "public1" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "elb1"
    Service = "ELB"
    type    = "public"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name    = "elb2"
    Service = "ELB"
    type    = "public"
  }
}
resource "aws_subnet" "private1" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "us-east-1a"


  tags = {
    Name    = "webserver1"
    type    = "private"
    Service = "webserver"
  }
}
resource "aws_subnet" "private2" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.3.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name    = "webserver2"
    type    = "private"
    Service = "webserver"
  }
}

resource "aws_subnet" "private3" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.4.0/24"
  availability_zone = "us-east-1c"


  tags = {
    Name    = "db1"
    type    = "private"
    Service = "db"
  }
}

resource "aws_subnet" "private4" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.5.0/24"
  availability_zone = "us-east-1d"


  tags = {
    Name    = "db2"
    type    = "private"
    Service = "db"
  }
}

# subnet routetable association
resource "aws_route_table_association" "nat_gateway_association" {
  subnet_id      = aws_subnet.nat_gateway_subnet.id
  route_table_id = aws_default_route_table.default_route_table.id
}
resource "aws_route_table_association" "public_sub_associate_1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_default_route_table.default_route_table.id
}

resource "aws_route_table_association" "public_sub_associate_2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_default_route_table.default_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_4" {
  subnet_id      = aws_subnet.private4.id
  route_table_id = aws_route_table.private_route_table.id
}

# Route Table Definitions
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = "rtb-af8d88d1"
  #default igw out
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-047f927e"
  }
  tags = {
    Name = "default table"
    type = "public"
  }

}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_default_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    type = "private"
  }

}

# nat gateway
resource "aws_eip" "nat_gateway_ip" {
  vpc              = true
}
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_ip.id
  subnet_id     = aws_subnet.nat_gateway_subnet.id
}
