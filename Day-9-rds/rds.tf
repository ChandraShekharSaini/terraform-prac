
resource "aws_db_subnet_group" "spring_db_subnet_group" {
    name = "spring-db-subnet-group"
    subnet_ids = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id]

    tags = {
        Name = "spring-db-subnet-group"
    }
}


resource "aws_db_instance" "spring_database" {
    identifier = "spring-database"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    allocated_storage = 20
    db_name = "springdb"
    username = "admin"
    password = "qazqaz123"
    vpc_security_group_ids = [aws_security_group.spring_sg.id]
    db_subnet_group_name = aws_db_subnet_group.spring_db_subnet_group.name

    maintenance_window = "Mon:00:00-Mon:03:00"

    deletion_protection = false

    publicly_accessible = true

    backup_retention_period = 7

    tags = {
        Name = "spring-database"
    }
   
}


resource "aws_db_instance" "spring_database_read_replica" {
  identifier = "spring-database-read-replica"

  replicate_source_db = aws_db_instance.spring_database.identifier

  instance_class = "db.t3.micro"

  publicly_accessible = true

  vpc_security_group_ids = [
    aws_security_group.spring_sg.id
  ]

  deletion_protection = false

  skip_final_snapshot = true

  tags = {
    Name = "spring-database-read-replica"
  }
}