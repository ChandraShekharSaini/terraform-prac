
variable "bucket_name" {
    description = "The name of the S3 bucket to create"
    type        = string

}

variable "bucket_versioning" {
    description = "Whether to enable versioning for the S3 bucket"
    type        = bool
    
}

variable "bucket_tags" {
    description = "Tags for the S3 bucket"
    type        = string
    
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
  
}

variable "vpc_dns_support" {
   description = "Whether to enable DNS support for the VPC"
   type        = bool

}

variable "vpc_dns_hostnames" {
   description = "Whether to enable DNS hostnames for the VPC"
   type        = bool

}