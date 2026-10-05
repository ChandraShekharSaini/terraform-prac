resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.vpc_dns_support
  enable_dns_hostnames = var.vpc_dns_hostnames

  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  cidr_block = var.public_subnet_1a_cidr
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = var.public_subnet_1a_availability_zone
  tags = {
    Name = "public_subnet_1a"
  }
}



resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

resource "aws_instance" "server"{
  ami = var.ami_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.my_security_group.id]
  subnet_id = aws_subnet.public_subnet_1a.id

  tags = {
    Name = "MyInstance"
  }
}
