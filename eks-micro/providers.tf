provider "aws" {
  region = "us-east-1"
}

terraform {
  cloud {
    organization = "Shakthi-MANJUNATHAN"

    workspaces {
      name = "microservices"
    }
  }
}