module "vpc" {
  source = "../../modules/vpc"

  name                 = var.name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs

}
module "eks" {
  source = "../../modules/eks"

  name               = var.name
  region             = var.region
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  kubernetes_version = var.kubernetes_version

  desired_size        = var.desired_size
  min_size            = var.min_size
  max_size            = var.max_size
  node_instance_types = var.node_instance_types

 
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
}

