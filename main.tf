terraform {
  required_version = ">= 1.7.2"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "2.20.1"
    }
  }

  # backend "s3" {
  #   endpoints                   = { s3 = "https://us-east-1.linodeobjects.com" }
  #   profile                     = "linode"
  #   skip_credentials_validation = true
  #   skip_requesting_account_id  = true
  #   skip_region_validation      = true
  #   skip_s3_checksum            = true
  #   bucket                      = "your-bucket-name"
  #   key                         = "state/terraform.tfstate"
  #   region                      = "us-east-1"
  # }

}