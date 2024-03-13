module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "5G-Core-Net"
  cluster_version = "1.29"

  cluster_endpoint_public_access  = true       #This specifies whether the cluster endpoint is publicly accessible.

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  cluster_addons = {
    coredns = {
      preserve    = true
      most_recent = true

      timeouts = {
        create = "25m"
        delete = "10m"
      }

      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    kube-proxy = {
      most_recent = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    vpc-cni = {
      most_recent = true

      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      service_account_role_arn = module.ebs_csi_irsa_role.iam_role_arn
      most_recent = true 
    }
  }

  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional_sg_rules.id
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional_sg_rules.id
    }
  }

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::891377170667:role/AWSServiceRoleForAmazonEKS"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::891377170667:user/Diaa"
      username = "Diaa"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::891377170667:user/Abdel-Naby"
      username = "Abdel-Naby"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::891377170667:user/Asmaa"
      username = "Asmaa"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::891377170667:user/Hesham"
      username = "Hesham"
      groups   = ["system:masters"]
    },{
      userarn  = "arn:aws:iam::891377170667:user/Mostafa"
      username = "Mostafa"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::891377170667:user/Abdallah"
      username = "Abdallah"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_accounts = [
    "891377170667"
  ]

  tags = {
    env = "prod"
    Terraform   = "true"
  }
}

