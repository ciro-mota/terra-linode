terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.39.0"
    }
  }
}

provider "linode" {
  token = var.LINODE_CLI_TOKEN
}