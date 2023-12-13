resource "random_password" "password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}

resource "linode_stackscript" "stack" {
  label       = "Nginx"
  description = "Install Nginx."
  is_public   = false
  script      = <<EOF
#!/bin/sh
curl -sk https://raw.githubusercontent.com/ciro-mota/terra-linode/main/scripts/nginx.sh | sh
EOF
  images = ["linode/ubuntu23.10", "linode/ubuntu23.04", "linode/ubuntu22.10",
    "linode/ubuntu22.04", "linode/ubuntu20.04", "linode/ubuntu18.04",
    "linode/ubuntu16.04lts", "linode/debian12", "linode/debian11",
    "linode/debian10", "linode/almalinux8", "linode/almalinux9",
    "linode/fedora37", "linode/fedora38", "linode/rocky8", "linode/rocky9",
    "linode/alpine3.14", "linode/alpine3.15", "linode/alpine3.16",
  "linode/alpine3.17", "linode/alpine3.18"]
}