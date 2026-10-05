
resource "aws_vpc" "my_vpc"{
cidr_block = "10.0.0.0/16"
    tags={
    Name = "springboot-vpc"

    }
}

resource "aws_subnet" "public_subnet_1a"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags={
    Name = "public-subnet-1a"
     }
}


resource "aws_subnet" "private_subnet_1a"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.2.0/24"
     availability_zone = "us-east-1a"

     tags={
        Name="private-subnet-1a"
     }

}


resource "aws_subnet" "public_subnet_1b"{
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.1.0.0/24"
    availability_zone = "us-east-1a"
    tags={
    Name = "public-subnet-1b"
     }
}

resource "aws_security_group" "my_security_group"{
    name = "my-security-group"
    description = "Allow SSH and HTTP traffic"
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }

}
            

resource "aws_internet_gateway" "my_igw"{
    vpc_id = aws_vpc.my_vpc.id
    tags={
    Name = "my-igw"
    }
}

resource "aws_route_table" "public_route_table"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}

resource "aws_route_table_association" "my_route_table_association"{
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table"{
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat.id
    }
}



resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "springboot-nat-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.private_subnet_1a.id

  tags = {
    Name = "springboot-nat-gateway"
  }

}

resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_route_table.id
}



resource "aws_instance" "ec2_instance" {
  ami = "ami-0b6d9d3d33ba97d99" 
  instance_type = "t2.medium"
  associate_public_ip_address = true
  subnet_id     = aws_subnet.public_subnet_1a.id
  security_groups = [aws_security_group.my_security_group.id]

  tags = {
    Name = "public-server"
  }
}



# terraform plan -target=aws_s3_bucket.my_bucket
# terraform apply -target=aws_s3_bucket.my_bucket
# terraform destroy -target=aws_s3_bucket.my_bucket
resource "s3_bucket" "my_bucket" {

name = "chandra-my-bucket-8nbnn"
    tag={
        Name = "chandra-my-bucket"
    }
  
}