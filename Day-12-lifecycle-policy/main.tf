
resource "aws_instance" "server"{
    ami = "ami-0f8848d57eb4fe2d2"
    instance_type = "t2.micro"
    subnet_id = "subnet-0e7abfb724199ca61"
    security_groups = ["sg-06351f0abdf8cf09d"]
    tags = {
        Name = "spring-server"
    }

#    lifecycle {
#         prevent_destroy = true
#     }

     lifecycle {
      ignore_changes = [
        tags["Name"],
      ]
    }
}