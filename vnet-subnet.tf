//Resource Group
resource "azurerm_resource_group" "terraform_sample" {
    name     = "terraform-sample"
    location = "${var.arm_region}"   
}

//The below variable code block for visual understanding of the above code block
# variable "arm_region" {
#   description = "The Azure region to create things in."
#   default     = "East US"

//Virtual Network
resource "azurerm_virtual_network" "my_vn" {
  name                = "tf-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.terraform_sample.location}"
  resource_group_name = "${azurerm_resource_group.terraform_sample.name}"
}
//Subnet for Frontend
resource "azurerm_subnet" "my_subnet_frontend" {
  name                 = "frontend"
  resource_group_name  = "${azurerm_resource_group.terraform_sample.name}"
  virtual_network_name = "${azurerm_virtual_network.my_vn.name}"
  address_prefixes      = ["10.0.1.0/24"]
}

//To the below output code will draw Frontend ID from above code block for better understanding
# output "frontend_id" {
#   value = "${azurerm_subnet.my_subnet_frontend.id}"

//Subnet for Backend
resource "azurerm_subnet" "my_subnet_backend" {
  name                 = "backend"
  resource_group_name  = "${azurerm_resource_group.terraform_sample.name}"
  virtual_network_name = "${azurerm_virtual_network.my_vn.name}"
  address_prefixes      = ["10.0.2.0/24"]
}

//To the below output code will draw Backend ID from above code block for better understanding
# output "backend_id" {
#   value = "${azurerm_subnet.my_subnet_backend.id}"
# }

//Subnet for DMZ
resource "azurerm_subnet" "my_subnet_dmz" {
  name                 = "dmz"
  resource_group_name  = "${azurerm_resource_group.terraform_sample.name}"
  virtual_network_name = "${azurerm_virtual_network.my_vn.name}"
  address_prefixes      = ["10.0.3.0/24"]
}

//To the below output code will draw DMZ ID from above code block for better understanding
# output "dmz_id" {
#   value = "${azurerm_subnet.my_subnet_dmz.id}"

