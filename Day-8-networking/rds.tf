
resource "aws_rds_cluster" "my_rds_cluster" {
  cluster_identifier      = "my-rds-cluster"
  engine                  = "mysql"
  engine_version          = "mysql_8.0"
  master_username         = "admin"
  master_password         = "qazqaz123"
  skip_final_snapshot     = true
  backup_retention_period = 7

  tags = {
    Name = "My-RDS-Cluster"
  }
}