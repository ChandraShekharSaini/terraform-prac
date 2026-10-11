module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.vpc_cidr_block
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc-id
  availability_zone = var.availability_zone
  cidr_block_public_1a = var.cidr_block_public_1a
  cidr_block_private_1a = var.cidr_block_private_1a

}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc-id

}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_micro = var.instance_micro
  subnet_id = module.subnet.public_subnet_1a_id
  security_sg_id = module.sg.security_group_id
  ec2_environment = var.ec2_environment
}

