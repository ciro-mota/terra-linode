output "linode_public_ip" {
  description = "Public IP Address of instance."
  value       = linode_instance.terraform-github[*].ip_address
  sensitive   = false
}