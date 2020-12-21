resource "aws_security_group" "load_balancer" {
  name        = "load_balancer"
  description = "Allow Internet Traffic"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "web_server" {
  name        = "webservers"
  description = "Allow Internet Traffic from ALB"
  vpc_id      = aws_default_vpc.default.id
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block,aws_subnet.private3.cidr_block,aws_subnet.private4.cidr_block]

  }
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.public1.cidr_block,aws_subnet.public2.cidr_block,aws_subnet.private3.cidr_block,aws_subnet.private4.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}