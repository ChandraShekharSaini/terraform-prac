terraform {
  backend "s3" {
    bucket = "amz-chandra-saini"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

