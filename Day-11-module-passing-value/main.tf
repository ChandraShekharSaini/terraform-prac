module "test" {
  source = "../Day-11-moule-vpc"

    # Passing values to the module
    vpc_cidr = "10.0.0.0/16"
    vpc_dns_support = true
    vpc_dns_hostnames = true
    public_subnet_1a_cidr = "10.0.1.0/24"
    public_subnet_1a_availability_zone = "us-east-1a"
    ami_id = "ami-0c55b159cbfafe1f0"
   
}