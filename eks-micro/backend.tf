terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Shakthi-MANJUNATHAN"  # Update with your organization name
    token        = var.TF_TOKEN

    workspaces {
      name = "microservices"
    }
  }
}
