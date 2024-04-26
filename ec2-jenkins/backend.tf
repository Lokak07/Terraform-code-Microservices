
terraform {
  backend "s3" {
    bucket = "micro-service-bucket-eks"
    key    = "micro-service-bucket-eks/log"
    region = "us-east-1"
  }
}
