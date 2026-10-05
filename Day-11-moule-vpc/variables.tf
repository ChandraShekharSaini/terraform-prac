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

variable "public_subnet_1a_cidr" {
   description = "The CIDR block for the public subnet in availability zone 1a"
   type        = string

}

variable "public_subnet_1a_availability_zone" {
   description = "The availability zone for the public subnet in availability zone 1a"
   type        = string
}

variable "ami_id"{
   description = "The AMI ID for the EC2 instance"
   type        = string
}
