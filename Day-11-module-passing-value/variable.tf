variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
}


variable "vpc_dns_support" {
  description = "Whether to support DNS support for the VPC"
  type        = bool
}

variable "vpc_dns_hostnames" {
  description = "Whether to support DNS hostnames for the VPC"
  type        = bool
}

variable "public_subnet_1a_cidr" {
  description = "CIDR block for the public subnet in availability zone 1a"
  type        = string
}

variable "public_subnet_1a_availability_zone" {
  description = "Availability zone for the public subnet in availability zone 1a"
  type        = string
}

variable "ami_id" {
  description = "ID of the AMI to use for the EC2 instance"
  type        = string
}

  
