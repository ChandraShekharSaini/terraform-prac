
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "my_instance" {
  ami           =  "ami-0d27e0fb3bac4d724"
  subnet_id     = "subnet-0d5adaa3e12bd6e79"
  security_groups = ["sg-0cb76de4a93ebdfd2"]
  key_name     = "my-key"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  tags = {
    Name = "provisioner-instance"
}

  connection {
  type        = "ssh"
  user        = "ec2-user"
  private_key = file("~/.ssh/id_ed25519")
  host        = aws_instance.my_instance.public_ip
  }

  provisioner "local-exec" {
    command = "echo Hello World > app.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo echo '<h1>Welcome to My Nginx Server</h1>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }

  provisioner "file" {
    source      = "files/"
    destination =  "/home/ec2-user/"

  }
}