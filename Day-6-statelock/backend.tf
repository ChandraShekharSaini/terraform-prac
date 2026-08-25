terraform {
  backend "s3" {
    bucket = "prashanth-aws-23kkk"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
