terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Shakthi-MANJUNATHAN"  # Update with your organization name
    TF_TOKEN = credentials('TF_token')

    workspaces {
      name = "microservices"
    }
  }
}
