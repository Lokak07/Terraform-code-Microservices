module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "micro-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.10.0.0/16"]
  tags = {
    Terraform   = "true"
    Environment = "dev"
    application = "Microservices"
  }
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  security_group_id = module.web_server_sg.security_group_id
}



