terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Shakthi-MANJUNATHAN"  # Update with your organization name
    token        = env.TF_TOKEN

    workspaces {
      name = "microservices"
    }
  }
}
