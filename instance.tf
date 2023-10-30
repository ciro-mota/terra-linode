resource "linode_instance" "terraform-github" {
  image           = var.image
  label           = "${var.label}-${count.index}"
  region          = var.linode_region
  type            = var.linode_instance_type
  count           = var.node_count
  authorized_keys = [var.public_key_path]
  root_pass       = random_password.password.result

  #  stackscript_id = linode_stackscript.deb.id # Switch to the stackscript you would like to deploy based on the distro used.
}