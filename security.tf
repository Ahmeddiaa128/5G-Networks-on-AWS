resource "aws_security_group" "additional_sg_rules" {
  name_prefix = "${local.name}-additional_sg_rules"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [local.vpc_cidr_source]
  }
    ingress {
    from_port = 30500
    to_port   = 30500
    protocol  = "tcp"
    cidr_blocks = [local.vpc_cidr_source]
  }

  tags = merge(local.tags, { Name = "${local.name}-additional_sg_rules" })
}

