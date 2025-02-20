resource "random_password" "password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}

resource "linode_stackscript" "stack" {
  label       = "Nginx"
  description = "Install Nginx. Only in stable versions."
  is_public   = false
  script      = <<EOF
#!/bin/sh
curl -sk https://raw.githubusercontent.com/ciro-mota/terra-linode/main/files/nginx.sh | sh
EOF
  images = ["linode/ubuntu24.04", "linode/ubuntu22.04",
    "linode/ubuntu20.04", "linode/debian12",
    "linode/almalinux8", "linode/almalinux9",
  "linode/rocky8", "linode/rocky9"]
}