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
  vpc_cidr_block = module.vpc.vpc_cidr_block
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
  ec2_scg_id = module.scg.ec2_private_scg_id
  ec2_type = var.instance_type
  image_id = var.ami
}

module "cloudfront" {
  source = "./09-cloudfront"
  nlb_dns_name = module.nlb.nlb_dns_name
  bucket_regional_domain_name = module.s3.bucket_regional_domain_name
}

module "vpc-endpoints" {
  source = "./10-vpc-endpoints"
  vpc_id = module.vpc.vpc_id
  region = "ap-southeast-1"
  vpc_endpoint_security_group_id = module.scg.vpc_endpoint_security_group_id
}

module "iam_profile" {
  source = "./11-iam"
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
  ec2_private_subnet_cidrs = module.subnets_public.subnet_ids[0]
  ec2_scg_name = module.scg.ec2_ssm_sg_id
  ec2_name = "maybank-1a"
  iam_instance_profile = module.iam_profile.ec2_instance_profile_name
}

module "rds" {
  source = "./rds"
  db_private_subnet_ids = module.subnets_private.subnet_ids
  db_scg_ids = [module.scg.mariadb_scg_id]
}

