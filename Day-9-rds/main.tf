
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
    cidr_block = "10.0.0.0/18"
    availability_zone = "us-east-1a"
    tags={
    Name = "public-subnet-1a"
     }
}


resource "aws_subnet" "private_subnet_1a"{
    vpc_id = aws_vpc.spring_vpc.id
    cidr_block = "10.0.64.0/18"
     availability_zone = "us-east-1a"

     tags={
        Name="private-subnet-1a"
     }

}


resource "aws_subnet" "public_subnet_1b"{
    vpc_id = aws_vpc.spring_vpc.id
    cidr_block = "10.0.128.0/18"
    availability_zone = "us-east-1b"
    tags={
    Name = "public-subnet-1b"
     }
}

resource "aws_subnet" "private_subnet_1b"{
    
    cidr_block = "10.0.192.0/18"
    vpc_id = aws_vpc.spring_vpc.id
    availability_zone = "us-east-1b"

 tags={
    Name = "private-subnet-1b"
     }
}


resource "aws_security_group" "spring_sg"{

vpc_id = aws_vpc.spring_vpc.id
    name = "spring-sg"
    description = "Allow SSH and HTTP traffic"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = 3306
        to_port = 3306
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

    egress  {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


resource "aws_internet_gateway" "spring_igw"{
    vpc_id = aws_vpc.spring_vpc.id

    tags={
        Name = "spring-igw"
    }
}

resource "aws_route_table" "spring_public_rt"{
    vpc_id = aws_vpc.spring_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.spring_igw.id
    }
}

resource "aws_route_table_association" "spring_public_rt_assoc_1a"{
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.spring_public_rt.id
}

resource "aws_route_table_association" "spring_public_rt_assoc_1b"{
    subnet_id = aws_subnet.public_subnet_1b.id
    route_table_id = aws_route_table.spring_public_rt.id
}

resource "aws_instance" "spring_server"{
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    associate_public_ip_address = true
    subnet_id = aws_subnet.public_subnet_1a.id
    security_groups = [aws_security_group.spring_sg.id]

    key_name = "eks-admin"

    root_block_device {
        volume_size = 8
        volume_type = "gp2"
        
    }

    tags = {
    Name = "eks-admin"
  }
}