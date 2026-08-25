variable "cidr_block" {
  description = "VPC CIDR Block"
  type = string
  default = ""
}

variable "public_subnet_1a" {
  description = "Public Subnet 1a CIDR Block"
  type = string
  default = ""
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type = string
  default = ""

}

