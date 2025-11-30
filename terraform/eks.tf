# Get whoever is running Terraform
data "aws_caller_identity" "current" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.2"

  name    = var.cluster_name
  kubernetes_version = "1.33"
  enable_irsa         = true
  create_cloudwatch_log_group = false

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

   # For Cluster API access
  # ------------------------------------------
  
  endpoint_public_access = true
  endpoint_private_access = false
  endpoint_public_access_cidrs = ["0.0.0.0/0"] # or restrict to your IP

  # Enable essential addons
  addons = {
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 1
      max_size       = 2
      min_size       = 1
    }
  }

  # --- Dynamic access entries ---
  access_entries = {
    caller_user = {
      principal_arn = data.aws_caller_identity.current.arn
      type          = "STANDARD"

      policy_associations = {
        admin-access = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}

