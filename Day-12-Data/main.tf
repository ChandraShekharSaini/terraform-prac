
data "aws_vpc" "spring_vpc" {
  filter {
    name   = "tag:Name"
    values = ["project-vpc"]
  }
}

data "aws_subnet" "spring_subnets" {
  filter {
    name   = "tag:Name"
    values = ["project-subnet-public1-us-east-1a"]
  }
}

data "aws_security_group" "spring_sg" {

  filter {
    name   = "tag:Name"
    values = ["spring-sg"]
  }

  vpc_id = data.aws_vpc.spring_vpc.id
}


data "aws_ami" "amazonlinux-backend" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "spring_instance" {
  ami           = data.aws_ami.amazonlinux-backend.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.spring_subnets.id
  security_groups = [data.aws_security_group.spring_sg.id]

  tags = {
    Name = "spring-instance"
  }
}