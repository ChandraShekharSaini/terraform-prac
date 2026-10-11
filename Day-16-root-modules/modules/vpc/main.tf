
resource "aws_vpc" "spring_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name:"spring-vpc"
  }
}

