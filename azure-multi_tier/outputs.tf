output "vnet_cidr" {
  value = azurerm_virtual_network.primary.address_space
}

output "vnet_info" {
  value = azurerm_virtual_network.primary
}