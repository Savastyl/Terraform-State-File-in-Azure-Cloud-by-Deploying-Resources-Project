//Availability Set
resource "azurerm_availability_set" "frontend" {
  name                         = "tf-avail-set"
  location                     = azurerm_resource_group.terraform_sample.location
  resource_group_name          = azurerm_resource_group.terraform_sample.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 20
  managed                      = true
  tags = {
    environment = "Production"
  }
}
//Storage Container for O,1
resource "azurerm_storage_container" "frontend" {
  count                 = var.arm_frontend_instances
  name                  = "tf-storage-container-${count.index}"
  storage_account_name  = azurerm_storage_account.frontend.name
  container_access_type = "private"
}
//Network Interface for 0,1 
resource "azurerm_network_interface" "frontend" {
  count               = var.arm_frontend_instances
  name                = "tf-interface-${count.index}"
  location            = azurerm_resource_group.terraform_sample.location
  resource_group_name = azurerm_resource_group.terraform_sample.name
//IP Configuration for 0,1
  ip_configuration {
    name                          = "tf-ip-${count.index}"
    subnet_id                     = azurerm_subnet.my_subnet_frontend.id
    private_ip_address_allocation = "Dynamic"
  }
}
//Virtual Machine for 0,1
resource "azurerm_virtual_machine" "frontend" {
  count                 = var.arm_frontend_instances
  name                  = "tf-instance-${count.index}"
  location              = azurerm_resource_group.terraform_sample.location
  resource_group_name   = azurerm_resource_group.terraform_sample.name
  network_interface_ids = ["${element(azurerm_network_interface.frontend.*.id, count.index)}"]
  vm_size               = "Standard_DS1_v2"
  availability_set_id   = azurerm_availability_set.frontend.id

//The below variable code block for visual understanding of the above code block
  # variable "arm_frontend_instances" {
  #   description = "Number of front instances"
  #   default     = 2
  

//Storage Image Reference
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
//Storage OS Disk for 0,1
  storage_os_disk {
    name              = "tf-osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  # Optional data disks
//Storage Data Disk for 0,1
  storage_data_disk {
    name              = "tf-datadisk-${count.index}"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = "1023"
    create_option     = "Empty"
    lun               = 0
  }
//Delete OS Disk on Termination
  delete_os_disk_on_termination    = true
//Delete Data Disk on Termination
  delete_data_disks_on_termination = true

//OS Profile for 0,1
  os_profile {
    computer_name  = "tf-instance-${count.index}"
    admin_username = "demo"
    admin_password = var.arm_vm_admin_password
  }

//The below variable code block for visual understanding of the above code block
  #   variable "arm_vm_admin_password" {
  #   description = "Passwords for the root user in VMs."
  #   default     = "SUper.123-" # This should be hidden and passed as variable, doing this just for training purpose
  
//OS Profile Linux Config
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
