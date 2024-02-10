#creates an IAM role for the Amazon EBS CSI driver running in your EKS cluster, and grants it the necessary permissions to manage Amazon EBS volumes and snapshots. 
module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name             = "${local.name}-ebs-csi"
  attach_ebs_csi_policy = true               #This policy grants the role the necessary permissions to manage Amazon EBS volumes and snapshots.

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

