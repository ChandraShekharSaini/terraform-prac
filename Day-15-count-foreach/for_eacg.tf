variable "tags" {
    description = "Tgs Name"
    default = ["dev","test"]
    type = list(string)
}
resource "aws_instance" "server" {

    for_each = toset(var.tags)

    ami = "ami-07f9c6534b9c70941"
    vpc_security_group_ids = ["sg-0fd90ee01c93470b1"]
    subnet_id = "subnet-075c4bb77dbf0baef"
    instance_type = "t2.micro"

    tags = {
      Name: each.value
    }
  
}
# ======================================================

locals {
  subnet_ids = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
    aws_subnet.subnet3.id
  ]
}

resource "aws_route_table_association" "private" {
  for_each = toset(local.subnet_ids)

  subnet_id = each.value

  route_table_id = aws_route_table.private.id
}

