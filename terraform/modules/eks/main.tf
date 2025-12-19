terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.name}-eks"
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # API endpoint access (POC-friendly)
 cluster_endpoint_public_access = var.cluster_endpoint_public_access


  # Enable IRSA for future add-ons
  enable_irsa = true

  # Explicitly grant cluster admin access to cli-user
  access_entries = {
    cli_user_admin = {
      principal_arn = "arn:aws:iam::644669979904:user/cli-user"

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  eks_managed_node_groups = {
    default = {
      name           = "${var.name}-ng"

      desired_size = var.desired_size
      min_size     = var.min_size
      max_size     = var.max_size
      node_instance_types = var.node_instance_types

      subnet_ids = var.private_subnet_ids

      

    }
  }

  tags = {
    Project = var.name
  }
}
