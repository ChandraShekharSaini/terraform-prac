
variable "security_ports" {
  description = "Security Group Ports"
  default = [80, 443, 3306]
}

resource"aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "My security group"
  vpc_id      = "vpc-04742aee4c5eccd20"

  ingress = [
    for port in var.security_ports  : {
      description      = "Allow port ${port}"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "my_instance" {
    
    subnet_id = "subnet-075c4bb77dbf0baef"
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    instance_type = "t2.micro"
    key_name = aws_key_pair.my_key_pair.key_name
    ami = data.aws_ami.amazon_linux.id

  tags = {
    Name = "server"
  }


}