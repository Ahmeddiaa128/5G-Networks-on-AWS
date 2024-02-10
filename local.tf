locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-east-1"
  ubuntu_ami_id = "ami-053b0d53c279acc90"
  vpc_cidr = "10.0.0.0/16"
  vpc_cidr_source = "0.0.0.0/0"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  
  ebs_csi_service_account_namespace = "kube-system"
  ebs_csi_service_account_name = "ebs-csi-controller-sa"

  tags = {
    name    = local.name
    terraform = "true"
    env  = "prod"
  }
}

