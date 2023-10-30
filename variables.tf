variable "LINODE_CLI_TOKEN" {
  sensitive = true
}

variable "public_key_path" {
  sensitive = true
}

variable "node_count" {
  description = "Defines the number of instances that will be provisioned."
  default     = 1
}

variable "image" {
  type        = string
  description = "Linode Image type to use. See linode-available-resources.txt file for available images."
  default     = "linode/debian12"
}
variable "label" {
  type        = string
  description = "The name you want for your Linode instance."
  default     = "Terra_Linode"
}

variable "linode_region" {
  type        = string
  description = "Linode available regions to use. See linode-available-resources.txt file for available regions."
  default     = "us-east"
}
variable "linode_instance_type" {
  type        = string
  description = "Linode machine types to use. See linode-available-resources.txt file for instance types."
  default     = "g6-nanode-1"
}