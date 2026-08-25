resource "aws_s3_bucket" "name" {

tags = {
    Name = var.bucket_name
  }
}


resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block

  tags = {
    Name = "public-server-1"
  }
  
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_1a
  availability_zone = "us-east-1a"


  tags = {
    Name = "public-subnet-1a"
  }
}




