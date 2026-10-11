resource "aws_key_pair" "name" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}


resource "aws_instance" "server" {

  for_each =   toset(var.ec2_environment)

  ami                    = var.ami_id
  instance_type = var.instance_micro
  subnet_id              = var.subnet_id
  associate_public_ip_address =  true
  vpc_security_group_ids = [var.security_sg_id]

  key_name = aws_key_pair.name.key_name

  tags = {
    Name = "server-${each.value}"
  }
}