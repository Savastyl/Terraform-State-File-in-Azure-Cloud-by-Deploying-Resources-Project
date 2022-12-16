//The Azure region to create things in.
variable "arm_region" {
  description = "The Azure region to create things in."
  default     = "East US"
}
//Passwords for the root user in VMs.
variable "arm_vm_admin_password" {
  description = "Passwords for the root user in VMs."
  default     = "SUper.123-"     #This should be hidden and passed as variable, doing this just for better understanding purpose
}
//Number of front instance
variable "arm_frontend_instances" {
  description = "Number of front instances"
  default     = 2
}
