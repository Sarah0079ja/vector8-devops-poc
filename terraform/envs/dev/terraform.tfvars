region = "eu-west-3"
name   = "vector8-dev"

vpc_cidr = "10.0.0.0/16"

azs = ["eu-west-3a", "eu-west-3b"]

public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
cluster_endpoint_public_access = true

# EKS node group sizing
desired_size        = 2
min_size            = 1
max_size            = 2
node_instance_types = ["t3.micro"]
