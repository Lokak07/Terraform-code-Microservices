terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-organization"
    token        = var.TF_TOKEN

    workspaces {
      name = "your-workspace"
    }
  }
}

