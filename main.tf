# main.tf

# Provider configuration
provider "aws" {
  region = "us-east-2"
}

# EKS Cluster Module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "eks-dev"
  kubernetes_version = "1.33"  # use supported version (1.33 not available yet)

  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # ✅ Add tags here (you already did this correctly)
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
