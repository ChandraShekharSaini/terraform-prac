variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for subnet"
  default     = "us-east-1a"
}

variable "cidr_block_public_1a" {
  type        = string
  description = "Public subnet CIDR"
  default     = "10.0.0.0/17"
}

variable "cidr_block_private_1a" {
  type        = string
  description = "Private subnet CIDR"
  default     = "10.0.128.0/17"
}

variable "ami_id" {
   type        = string
  description = "Private subnet CIDR"
  default     = "ami-02dfbd4ff395f2a1b"
  
}

variable "instance_micro" {
  type        = string
  description = "Private subnet CIDR"
  default     = "t2.micro"
  
}

variable "ec2_environment"{
  type = list(string)
  description = "value"
  default = ["dev","test","prod"]
}