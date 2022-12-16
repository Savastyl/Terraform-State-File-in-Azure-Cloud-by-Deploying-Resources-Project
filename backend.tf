//To store tfstate of the project here
terraform {
  backend "azurerm" {
    storage_account_name = "savas55stg"             // Use your own unique name here
    container_name       = "savas55container"       // Use your own container name here
    key                  = "terraformsav55.tfstate" // Add a name to the state file
    resource_group_name  = "savas55rg"              // Use your own resource group name here
  }
}