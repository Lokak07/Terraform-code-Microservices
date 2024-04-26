terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-organization"
    token        = "Vdmy7nkWmaOeyA.atlasv1.qiRCblGtXbARSZzCxrPrFdCWgTZGj4P9vM3anVJcCBcezOoRXheRgPFUgXIqSxHQfKA"  # Add your token here

    workspaces {
      name = "your-workspace"
    }
  }
}

