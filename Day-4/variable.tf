

variable "cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
   
}

variable "vpc_tag_name"{
    description = "The name tag for the VPC"
    type        = string
 
}

variable "s3_kms_master_key_id" {
  description = "The KMS master key ID for the S3 bucket"
    type        = string
  
}

variable "flag_true" {
    description = "A boolean variable set to true"
    type        = bool
  
  
}