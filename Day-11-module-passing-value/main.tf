module "test" {
  source = "../Day-11-moule-vpc"

  
    vpc_cidr = var.vpc_cidr 
    vpc_dns_support = var.vpc_dns_support
    vpc_dns_hostnames = var.vpc_dns_hostnames
    public_subnet_1a_cidr = var.public_subnet_1a_cidr
    public_subnet_1a_availability_zone = var.public_subnet_1a_availability_zone
    ami_id = var.ami_id
   
}