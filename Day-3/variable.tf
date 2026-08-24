variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "az1" {
  description = "Availability Zone 1"
  type        = string
}

variable "az2" {
  description = "Availability Zone 2"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for Public Subnet 1"
  type        = string
}

variable "public_subnet_1_name" {
  description = "Name of Public Subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for Public Subnet 2"
  type        = string
}

variable "public_subnet_2_name" {
  description = "Name of Public Subnet 2"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for Private Subnet 1"
  type        = string
}

variable "private_subnet_1_name" {
  description = "Name of Private Subnet 1"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for Private Subnet 2"
  type        = string
}

variable "private_subnet_2_name" {
  description = "Name of Private Subnet 2"
  type        = string
}

variable "igw_name" {
  description = "Internet Gateway Name"
  type        = string
}

variable "nat_eip_name" {
  description = "Elastic IP Name"
  type        = string
}

variable "nat_gateway_name" {
  description = "NAT Gateway Name"
  type        = string
}

variable "public_route_table_name" {
  description = "Public Route Table Name"
  type        = string
}

variable "private_route_table_name" {
  description = "Private Route Table Name"
  type        = string
}