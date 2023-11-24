# This is the main part of vpc tf stack modules are separated in terraform modules directory

# define local block to use theese values easily 
locals {
  aws_region       = "us-east-1"
  environment_name = "dev"
  tags = {
    ops_env              = "${local.environment_name}"
    ops_managed_by       = "terraform",
    ops_source_repo      = "k8sclusters",
    ops_source_repo_path = "terraform-environments/aws/${local.environment_name}/10-vpc",
    ops_owners           = "devops",
  }
}

module "vpc" {
  source = "git::https://github.com/csokai/k8sclusters/terraform-modules/aws/vpc?ref=main"

  aws_region       = local.aws_region
  azs              = ["us-east-1a", "us-east-1c", "us-east-1d"]
  vpc_cidr         = "10.0.0.0/16"
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  environment_name = local.environment_name
  cluster_name     = local.environment_name
  tags             = local.tags
}