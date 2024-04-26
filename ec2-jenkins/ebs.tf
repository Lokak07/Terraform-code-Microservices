resource "aws_ebs_volume" "micro-services" {
  availability_zone = "us-east-1a"
  size              = 30

  tags = {
    Terraform   = "true"
    Environment = "dev"
    application = "Microservices"
  }
}

output "volumeid" {
  value = aws_ebs_volume.micro-services.id
}