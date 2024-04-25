module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.name

  instance_type               = var.instance_type
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = [module.web_server_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  ami                         = data.aws_ami.ubuntu.image_id
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    application = "Microservices"
  }
}

