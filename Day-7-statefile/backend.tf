terraform {
  backend "s3" {
    bucket = "amz-chandra-saini"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "chandra-saini-lock"
   ## use_lockfile ="true"
   
  }
}

#supports latest version >=1.10
#<1.10 we can use dynmodb for state locking as well, but s3 native locking is more efficient and cost effective
#State lockfile : Terraform acquires a state lock to protect the state from being written by multiple users at the same time. Please resolve the issue above and try again

