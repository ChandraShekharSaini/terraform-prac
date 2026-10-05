resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.vpc_dns_support
  enable_dns_hostnames = var.vpc_dns_hostnames

  tags = {
    Name = "my_vpc"
  }
}

resource "s3_bucket" "my_bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = var.bucket_versioning
  }

  tags = {
    Name = var.bucket_name
  }
}