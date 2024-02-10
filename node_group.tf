module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"

  name            = local.name
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version
  subnet_ids      = module.vpc.public_subnets


  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids = [
    module.eks.cluster_security_group_id, aws_security_group.additional_sg_rules.id,
  ]

  min_size     = 2
  max_size     = 8
  desired_size = 3

  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"

  ami_type = "AL2_x86_64"

  enable_bootstrap_user_data = true

  post_bootstrap_user_data = <<-EOF
  
  MIME-Version: 1.0
  Content-Type: multipart/mixed; boundary="==BOUNDARY=="

  --==BOUNDARY==
  Content-Type: text/x-shellscript; charset="us-ascii"

  #!/bin/bash
  sudo yum update -y
  sudo yum install kernel-devel -y
  yum install -y git
  git clone https://github.com/free5gc/gtp5g.git
  cd gtp5g
  sudo yum install -y make
  sed -i 's|KDIR := /lib/modules/$(KVER)/build|KDIR := /usr/src/kernels/$(uname -r)|' ./Makefile
  make
  sudo make install

  --==BOUNDARY==--
  EOF

  tags = merge(local.tags, { Separate = "eks-managed-node-group" })
}

