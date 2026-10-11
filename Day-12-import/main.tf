resource "aws_vpc" "spring_vpc" {
  tags = {
    Name = "spring_vpc"
  }
}

resource "aws_s3_bucket" "balti-mere" {

tags = {
    Name = "balti"
  }

}

resource "aws_s3_bucket_versioning" "balti-mere-versioning" {
  bucket = aws_s3_bucket.balti-mere.id

  versioning_configuration {
    status = "Enabled"
  }
}