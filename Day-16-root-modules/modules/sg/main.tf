resource "aws_security_group" "spring_sg" {

  name        = "spring-sg"
  description = "Allow required ports"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset([22, 80, 443])

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}