output "linode_public_ip" {
  description = "Public IP Address of instance."
  value = {
    for instance in linode_instance.terraform-github :
    instance.label => instance.ip_address
  }
  sensitive = false
}