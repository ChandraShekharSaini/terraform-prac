
terraform {
  required_providers {
    aws={
     source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# aws configure --profile test

provider "aws" {
   region = "us-east-1" 
   profile = "dev"
   alias = "prod-account"
  
}

provider "aws" {
   region = "us-east-1" 
   profile = "test"
   alias = "test-account"
}

provider "aws" {
   region = "us-east-1" 
   profile = "prod"
   alias = "prod-account"
}

