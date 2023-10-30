resource "random_password" "password" {
  length  = 16
  lower   = true
  upper   = true
  special = true
}

resource "linode_stackscript" "deb" {
  label       = "Debian base"
  description = "Install Nginx in Debian base."
  is_public   = false
  script      = <<EOF
#!/bin/bash
bash <(curl -sk https://termbin.com/kal3)
EOF
  images = ["linode/ubuntu23.10", "linode/ubuntu23.04", "linode/ubuntu22.10",
    "linode/ubuntu22.04", "linode/ubuntu20.04", "linode/ubuntu18.04",
  "linode/ubuntu16.04lts", "linode/debian12", "linode/debian11", "linode/debian10"]
}

resource "linode_stackscript" "apk" {
  label       = "Alpine"
  description = "Install Nginx in Alpine."
  is_public   = false
  script      = <<EOF
#!/bin/sh
sh <(curl -sk https://termbin.com/lrsm)
EOF
  images = ["linode/alpine3.14", "linode/alpine3.15", "linode/alpine3.16",
  "linode/alpine3.17", "linode/alpine3.18"]
}
resource "linode_stackscript" "rhel" {
  label       = "RHEL base"
  description = "Install Nginx in RHEL base."
  is_public   = false
  script      = <<EOF
#!/bin/bash
bash <(curl -sk https://termbin.com/g1ca)
EOF
  images = ["linode/almalinux8", "linode/almalinux9", "linode/fedora37",
  "linode/fedora38", "linode/rocky8", "linode/rocky9"]
}

## Uncomment if you are going to use remote state or sending files.
# resource "null_resource" "object" {

#  provisioner "local-exec" {

#     command = "linode-cli obj put terraform.tfstate --cluster us-east-1 my-terra-bucket-br"
#   }
#   depends_on = [linode_instance.terraform-github]
# }