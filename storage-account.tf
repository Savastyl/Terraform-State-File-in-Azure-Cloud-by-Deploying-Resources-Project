//Storage Account 
resource "azurerm_storage_account" "frontend" {
  name                     = "terrasavas"
  resource_group_name      = azurerm_resource_group.terraform_sample.name
  location                 = azurerm_resource_group.terraform_sample.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}