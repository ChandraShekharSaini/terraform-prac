
resource "aws_instance" "my_instance" {
  ami           =  "ami-0d27e0fb3bac4d724"
  subnet_id     = "subnet-0d5adaa3e12bd6e79"
  security_groups = ["sg-0cb76de4a93ebdfd2"]
  associate_public_ip_address = true
  instance_type = "t2.micro"
  user_data = file("userdata.sh")
  tags = {
    Name = "MyInstance"
  }
}