# ===============count==============
# ===============count==============
# ===============count==============
# variable "tags" {
#   description = "Instance Tags"
#   type = list(string)
#   default = ["dev","test","prod"]
# }

# resource "aws_instance" "count_server"{
#     ami = "ami-07f9c6534b9c70941"
#     vpc_security_group_ids = ["sg-0fd90ee01c93470b1"]
#     instance_type = "t2.micro"
#     subnet_id = "subnet-075c4bb77dbf0baef"
#     count = length(var.tags)
#   tags = {
#     Name: var.tags[count.index]
#   }
# }

locals {
  subnet_ids = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
    aws_subnet.subnet3.id
  ]
}

resource "aws_route_table_association" "private" {
  count = length(local.subnet_ids)

  subnet_id = local.subnet_ids[count.index]

  route_table_id = aws_route_table.private.id
}