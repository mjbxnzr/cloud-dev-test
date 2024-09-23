# Create the primary RDS instance in AZ1
resource "aws_db_instance" "my_rds" {
  identifier           = "primary-db"
  allocated_storage    = 20              # Free Tier allows up to 20 GB
  storage_type         = "gp2"           # General-purpose SSD
  engine               = "mariadb"       # Specify MariaDB engine
  instance_class       = "db.t3.micro"
  db_name              = "mydatabase"
  username             = var_db_user
  password             = var.db_pass
  availability_zone    = "ap-southeast-1b"
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = var.db_scg_ids
  backup_retention_period = 5
  multi_az             = false  # Disable Multi-AZ for primary DB, as we are manually creating the read replica

  skip_final_snapshot    = true

  tags = {
    Name = "MyRDSInstance"
  }
}

# Create DB Subnet Group for RDS
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = var.db_private_subnet_ids  # Both subnets for RDS and replica

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

# Create the RDS read replica in AZ2
resource "aws_db_instance" "my_rds_read_replica" {
  identifier             = "my-rds-read-replica"
  replicate_source_db    = aws_db_instance.my_rds.identifier  # The primary DB ID to replicate from
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  availability_zone      = "ap-southeast-1a" # Replica in a different AZ
#   db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids = var.db_scg_ids

  tags = {
    Name = "MyRDSReadReplica"
  }
}