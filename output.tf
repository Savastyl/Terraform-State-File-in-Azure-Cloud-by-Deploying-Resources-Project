// Output of Subnet for Frontend ID
output "frontend_id" {
  value = azurerm_subnet.my_subnet_frontend.id
}
// Output of Subnet for Backend ID
output "backend_id" {
  value = azurerm_subnet.my_subnet_backend.id
}
// Output of Subnet for DMZ ID
output "dmz_id" {
  value = azurerm_subnet.my_subnet_dmz.id
}
// Output of Load Balancer IP
output "load_balancer_ip" {
  value = azurerm_public_ip.frontend.ip_address
}