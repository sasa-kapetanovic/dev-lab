### AZURE VARIABLES
variable "rg_name" {
  type        = string
  default     = ""
  description = <<DESCRIPTION
The name of the Resource Group to create resources in.
Add as variable so we can run multiple instances of the same subscription.
DESCRIPTION
}

variable "location" {
  type        = string
  default     = ""
  description = "The Azure region to deploy resources in."
}

variable "subscription_id" {
  type        = string
  default     = ""
  description = "The Subscription ID to deploy resources in."
  
}

# Environment Variables

variable "environment" {
  description = "Environment tag for the resources"
  type        = string
  default     = ""
}

# VM Variables

variable "vm_name" {
  type        = string
  default     = ""
  description = "Virtual machine name"
}

variable "admin_username" {
  type        = string
  default     = ""
  description = "VM root/admin username"
}

variable "vm_disk_size" {
  type        = number
  default     = 50
  description = "Size of the VM OS disk in GB"
}

variable "ssh_public_key" {
  type        = string
  default = ""
  description = "SSH public key content"
}
