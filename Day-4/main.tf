resource "aws_vpc" "spring" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_tag_name
  }
}


resource "s3_bucket" "bucket"{

  versioning {
    enabled = true
  }

  public_access_block_configuration {
    block_public_acls       = var.flag_true
    block_public_policy     = var.flag_true
    ignore_public_acls      = var.flag_true
    restrict_public_buckets = var.flag_true
  }

  KMS_master_key_id = var.s3_kms_master_key_id

  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }

  tags = {
    Name = "spring-bucket-terraform"
  }
}