


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My-Vpc"
  }
}
resource "aws_security_group" "my_sg" {

  name = "my-sg"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend-sg"
  }
}

resource "aws_subnet" "public_subnet-1a" {
  vpc_id = aws_vpc.my_vpc.id

  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_instance" "public_server_1a"{
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.public_subnet-1a.id
  security_groups = [aws_security_group.my_sg.id]

  tags = {
    Name = "public-server11-1a"
  }
}