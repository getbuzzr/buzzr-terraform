# VPC definitions
resource "aws_default_vpc" "default" {

  tags = {
    Name = "Default VPC"
  }
}

#  Subnet definitions
resource "aws_subnet" "public_elb1" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "elb1"
    Service = "ELB"
    type    = "public"
  }
}

resource "aws_subnet" "public_elb2" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.1.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name    = "elb2"
    Service = "ELB"
    type    = "public"
  }
}
resource "aws_subnet" "private_webserver1" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.2.0/24"
  availability_zone = "us-east-1a"


  tags = {
    Name    = "webserver1"
    type    = "private"
    Service = "webserver"
  }
}
resource "aws_subnet" "private_webserver2" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.3.0/24"
  availability_zone = "us-east-1b"


  tags = {
    Name    = "webserver2"
    type    = "private"
    Service = "webserver"
  }
}

resource "aws_subnet" "private_db1" {
  vpc_id            = aws_default_vpc.default.id
  cidr_block        = "172.31.4.0/24"
  availability_zone = "us-east-1c"


  tags = {
    Name    = "db1"
    type    = "private"
    Service = "db"
  }
}

resource "aws_subnet" "private_db2" {
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

resource "aws_route_table_association" "public_sub_associate_1" {
  subnet_id      = aws_subnet.public_elb1.id
  route_table_id = aws_default_route_table.default_route_table.id
}

resource "aws_route_table_association" "public_sub_associate_2" {
  subnet_id      = aws_subnet.public_elb2.id
  route_table_id = aws_default_route_table.default_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_1" {
  subnet_id      = aws_subnet.private_webserver1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_2" {
  subnet_id      = aws_subnet.private_webserver2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_3" {
  subnet_id      = aws_subnet.private_db1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_sub_associate_4" {
  subnet_id      = aws_subnet.private_db2.id
  route_table_id = aws_route_table.private_route_table.id
}

# Route Table Definitions
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = "rtb-de97c9a0"

  tags = {
    Name = "default table"
    type = "public"
  }

}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_default_vpc.default.id

  tags = {
    type = "private"
  }

}
