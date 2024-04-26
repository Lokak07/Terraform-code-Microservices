resource "aws_s3_bucket" "micro-service-bucket-eks" {
  bucket        = "micro-service-bucket-eks"
  force_destroy = false

  tags = {
    Name        = "micro-service-bucket-eks"
    Environment = "Dev"
  }


}