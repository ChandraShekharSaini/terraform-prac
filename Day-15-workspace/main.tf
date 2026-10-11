
resource "aws_instance" "server" {
  
    ami = "ami-07f9c6534b9c70941"
    vpc_security_group_ids = ["sg-0fd90ee01c93470b1"]
    subnet_id = "subnet-075c4bb77dbf0baef"
    instance_type = "t2.micro"

  tags = {
    Name: "workspace"
  }
}