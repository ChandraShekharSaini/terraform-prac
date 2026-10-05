output "vpc_cidr" {
   value = aws_vpc.my_vpc.cidr_block
  
}

output "vpc_dns_support" {
   value = aws_vpc.my_vpc.enable_dns_support
}



output "vpc_dns_hostnames" {
  value = aws_vpc.my_vpc.enable_dns_hostnames
}

output "public_subnet_1a_cidr" {
  value = aws_subnet.public_subnet_1a.cidr_block
}




output "public_subnet_1a_availability_zone" {
  value = aws_subnet.public_subnet_1a.availability_zone
}

