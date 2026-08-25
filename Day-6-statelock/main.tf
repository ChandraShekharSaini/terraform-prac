
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My-Vpc"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/17"

  tags = {
    Name = "public-subnet-1a"
  }

}

resource "aws_vpc" "my_vpc2" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "My-Vpc"
  }
}


resource "aws_vpc" "my_vpc3" {
  cidr_block = "10.20.0.0/16"

  tags = {
    Name = "My-Vpc2"
  }
}
