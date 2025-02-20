resource "linode_instance" "terraform-github" {
  image           = var.image
  label           = "${var.label}-${count.index}"
  region          = var.linode_region
  type            = var.linode_instance_type
  count           = var.node_count
  authorized_keys = [var.public_key_path]
  root_pass       = random_password.password.result

  # provisioner "file" {
  #   source      = "files/index.html.j2"
  #   destination = "/tmp/index.html.j2"
  # }

  # stackscript_id = linode_stackscript.stack.id # Switch to stackscript if you would like deployments based on the distribution used.
}