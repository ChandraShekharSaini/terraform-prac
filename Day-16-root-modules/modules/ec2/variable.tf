

variable "ami_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "security_sg_id" {
  type = string
}

variable "instance_micro" {
 type = string 
}


variable "ec2_environment"{
  type = list(string)

}