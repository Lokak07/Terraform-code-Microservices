
terraform {
  backend "s3" {
    bucket = "micro-service-bucket-eks"
    key    = "micro-service-bucket-eks/eks"
    region = "us-east-1"
  }
}

*/
