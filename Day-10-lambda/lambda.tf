

resource "aws_vpc" "spring_vpc"{
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags ={
        Name = "spring-vpc"
    }
}


resource "aws_subnet" "public_subnet_1a"{
    vpc_id = aws_vpc.spring_vpc.id
    cidr_block = "10.0.0.0/17"
    availability_zone = "us-east-1a"
    tags={

        Name = "public-subnet-1a"
    }
}

resource "aws_subnet" "private_subnet_1b"{
    vpc_id = aws_vpc.spring_vpc.id
    cidr_block = "10.0.128.0/17"
    availability_zone = "us-east-1b"
    tags={
        Name="private-subnet-1b"
    }
}


resource "aws_security_group" "spring_sg"{
    
    vpc_id = aws_vpc.spring_vpc.id
    name = "spring-sg"
    description = "Allow SSH and HTTP traffic"

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
   egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
        Name = "spring-vpc-sg"
   }
}


# ------------------------------------------------
# Create ZIP file
# ------------------------------------------------

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# ------------------------------------------------
# IAM Role for Lambda
# ------------------------------------------------

resource "aws_iam_role" "lambda_role" {

  name = "terraform-lambda-admin-role"

  # Trust Policy
  # Allows Lambda service to assume this role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ------------------------------------------------
# AdministratorAccess
# ------------------------------------------------

resource "aws_iam_role_policy_attachment" "lambda_admin" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# ------------------------------------------------
# Lambda Function
# ------------------------------------------------

resource "aws_lambda_function" "admin_lambda" {

  function_name = "terraform-admin-lambda"

  role = aws_iam_role.lambda_role.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename = data.archive_file.lambda_zip.output_path

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  depends_on = [
    aws_iam_role_policy_attachment.lambda_admin
  ]
}
