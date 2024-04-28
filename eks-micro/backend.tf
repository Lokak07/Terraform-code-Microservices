terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Shakthi-MANJUNATHAN"  # Update with your organization name
    

    workspaces {
      name = "microservices"
    }
  }
}
