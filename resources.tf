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
bash <(curl -sk https://raw.githubusercontent.com/ciro-mota/terra-linode/main/scripts/nginx.sh)
EOF
  images = ["linode/ubuntu23.10", "linode/ubuntu23.04", "linode/ubuntu22.10",
  "linode/ubuntu22.04", "linode/ubuntu20.04", "linode/ubuntu18.04",
  "linode/ubuntu16.04lts", "linode/debian12", "linode/debian11",
  "linode/debian10", "linode/almalinux8", "linode/almalinux9",
  "linode/fedora37", "linode/fedora38", "linode/rocky8", "linode/rocky9"]
}

resource "linode_stackscript" "apk" {
  label       = "Alpine"
  description = "Install Nginx in Alpine."
  is_public   = false
  script      = <<EOF
#!/bin/sh
sh <(curl -sk https://raw.githubusercontent.com/ciro-mota/terra-linode/main/scripts/nginx.sh)
EOF
  images = ["linode/alpine3.14", "linode/alpine3.15", "linode/alpine3.16",
  "linode/alpine3.17", "linode/alpine3.18"]
}

# Uncomment one of the two resources below if you are going to use remote state or sending files.
# resource "null_resource" "object" {

#  provisioner "local-exec" {

#     command = "aws s3 cp terraform.tfstate s3://<your-bucket-name> --endpoint=https://<your-endpoint-region>.linodeobjects.com"
#   }
#   depends_on = [linode_instance.terraform-github]
# }

# resource "null_resource" "object" {

#  provisioner "local-exec" {

#     command = "linode-cli obj put terraform.tfstate --cluster <your-region> <your-bucket-name>"
#   }
#   depends_on = [linode_instance.terraform-github]
# }
