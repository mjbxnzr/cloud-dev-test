module "vpc" {
  source          = "./01-vpc"
  cidr_block      = var.vpc_cidr
  vpc_name        = "my-vpc"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags           = {
    Environment = "dev"
  }
}

module "subnets_public" {
  source = "./02-subnet"
  vpc_id = module.vpc.vpc_id
  subnet_configs = [
    {
      cidr_block        = var.public_subnet_cidrs[0]
      availability_zone = var.availability_zones[0]
      map_public_ip_on_launch = true
      name              = "Public Subnet-1"
    },
    {
      cidr_block        = var.public_subnet_cidrs[1]
      availability_zone = var.availability_zones[1]
      map_public_ip_on_launch = false
      name              = "Public Subnet-2"
    }
  ]
  tags = {
    Environment = "dev"
  }
}

module "subnets_private" {
  source = "./02-subnet"
  vpc_id = module.vpc.vpc_id
  subnet_configs = [
    {
      cidr_block        = var.private_subnet_cidrs[0]
      availability_zone = var.availability_zones[0]
      map_public_ip_on_launch = true
      name              = "Private Subnet-1"
    },
    {
      cidr_block        = var.private_subnet_cidrs[1]
      availability_zone = var.availability_zones[1]
      map_public_ip_on_launch = true
      name              = "Private Subnet-2"
    }
  ]
  tags = {
    Environment = "dev"
  }
}

module "route_table" {
  source = "./03-rt"
  subnet_public_id = module.subnets_public.subnet_ids[0]
  subnet_private_id = module.subnets_private.subnet_ids[0]
  nat_gw_id = module.my_nat_gw.nat_gw_id[0]
  igw_id = module.my_igw.igw_id
  vpc_id = module.vpc.vpc_id
}

module "my_igw" {
  source = "./04-igw"
  vpc_id = module.vpc.vpc_id
  main_route_table_id = module.route_table.main_route_table_id
}

module "my_nat_gw" {
  source = "./05-nat-gw"
#   subnets_public = [module.subnets_public.subnet_ids[0], module.subnets_public.subnet_ids[1]]
  subnets_public = [for subnets in module.subnets_public.subnet_ids: subnets]
}

module "scg" {
  source = "./06-scg"
  vpc_id = module.vpc.vpc_id
}

module "nlb" {
  source = "./07-lb"
  vpc_id = module.vpc.vpc_id
  subnet_ids = [for subnet_id in module.subnets_public.subnet_ids : subnet_id]
  scg_nlb_id = module.scg.nlb_security_group_id
}

module "asg-1b" {
  source = "./08-asg"
  asg_subnet_ids = [module.subnets_private.subnet_ids[1]]
  asg_lb_target_gp_arn = module.nlb.lb_target_group_arn
  ec2_scg_id = module.scg.ec2_scg_id
  ec2_type = var.instance_type
  image_id = var.ami
}

# S3 bucket
module "s3" {
  source = "./s3-bucket"
  bucket = var.bucket_name
  name   = "Maybank Bucket"
  env    = "Dev"
}

module "ec2-1a" {
  source = "./ec2"
  image_id = var.ami
  ec2_type = var.instance_type
  ec2_private_subnet_cidrs = module.subnets_private.subnet_ids[0]
  ec2_scg_name = module.scg.ec2_scg_id
  ec2_name = "maybank-1a"
}

module "rds" {
  source = "./rds"
  db_private_subnet_ids = module.subnets_private.subnet_ids
  db_scg_ids = [module.scg.mariadb_scg_id]
}

#
# # Launch Template for EC2 instances
# # resource "aws_launch_template" "template" {
# #   name_prefix     = "MyEC2Instanc-1b"
# #   image_id        = var.ami
# #   instance_type   = var.instance_type
# #   vpc_security_group_ids = [aws_security_group.ec2_sg.name]
# # }
# #
# # resource "aws_autoscaling_group" "autoscale" {
# #   name                  = "test-autoscaling-group"
# #   desired_capacity      = 3
# #   max_size              = 6
# #   min_size              = 3
# #   health_check_type     = "EC2"
# #   termination_policies  = ["OldestInstance"]
# #   vpc_zone_identifier   = [aws_subnet.private_subnet_1b.id]
# #   target_group_arns = [aws_lb_target_group.tg.arn]
# #
# #   launch_template {
# #     id      = aws_launch_template.template.id
# #     version = "$Latest"
# #   }
# # }
#
# # Create the primary RDS instance in AZ1
# # resource "aws_db_instance" "my_rds" {
# #   allocated_storage    = 20
# #   engine               = "mysql"
# #   engine_version       = "8.0"
# #   instance_class       = "db.t2.micro"
# #   db_name              = "mydatabase"
# #   username             = "admin"
# #   password             = "password123"  # Replace with a stronger password
# #   db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
# #   vpc_security_group_ids = [aws_security_group.mariadb_sg.id]
# #   multi_az             = false  # Disable Multi-AZ for primary DB, as we are manually creating the read replica
# #
# #   tags = {
# #     Name = "MyRDSInstance"
# #   }
# # }
#
# # Create DB Subnet Group for RDS
# resource "aws_db_subnet_group" "my_db_subnet_group" {
#   name       = "my-db-subnet-group"
#   subnet_ids = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id]  # Both subnets for RDS and replica
#
#   tags = {
#     Name = "MyDBSubnetGroup"
#   }
# }
#
# # Create the RDS read replica in AZ2
# # resource "aws_db_instance" "my_rds_read_replica" {
# #   identifier             = "my-rds-read-replica"
# #   replicate_source_db    = aws_db_instance.my_rds.id  # The primary DB ID to replicate from
# #   instance_class         = "db.t2.micro"
# #   publicly_accessible    = false
# #   availability_zone      = "us-east-1a" # Replica in a different AZ
# #   db_subnet_group_name   = aws_db_subnet_group.my_db_subnet_group.name
# #   vpc_security_group_ids = [aws_security_group.mariadb_sg.id]
# #
# #   tags = {
# #     Name = "MyRDSReadReplica"
# #   }
# # }
