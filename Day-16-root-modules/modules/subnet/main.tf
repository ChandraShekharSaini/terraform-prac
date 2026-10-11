
resource "aws_subnet" "public_subnet_1a" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block_public_1a
  availability_zone = var.availability_zone

  tags = {
    Name:"public_subnet_1a"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block_private_1a
  availability_zone = var.availability_zone 

  tags = {
    Name:"private_subnet_1a"
  }
}




