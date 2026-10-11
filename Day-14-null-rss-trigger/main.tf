resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
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
  ami                         = data.aws_ami.amazon_linux.id
  subnet_id                   = "subnet-002230f3f85181fac"
  vpc_security_group_ids      = ["sg-0325ceea80af5d7da"]
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  tags = {
    Name = "provisioner-instance"
  }

  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}
resource "null_resource" "copy_file" {

  triggers = {
    file_hash = filemd5("app.txt")
  }

  connection {
    type        = "ssh"
    host        = aws_instance.my_instance.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/id_ed25519")
  }

  provisioner "file" {
    source      = "app.txt"
    destination = "/home/ec2-user/app.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "echo '<h1>Welcome to My Nginx Server</h1>' | sudo tee /usr/share/nginx/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }

  depends_on = [
    aws_instance.my_instance
  ]
}