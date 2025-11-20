# Resorce Group
resource "azurerm_resource_group" "base" {
  name     = var.resource_group_info.name
  location = var.resource_group_info.primary_region

}

# virtiual networks
# Primary VNet
resource "azurerm_virtual_network" "primary" {
  name                = var.primary_network_info.name
  address_space       = [var.primary_network_info.cidr]
  location            = var.resource_group_info.primary_region
  resource_group_name = azurerm_resource_group.base.name

  depends_on = [azurerm_resource_group.base]

}

# Subnets
resource "azurerm_subnet" "primary_subnets" {
  count                = length(var.primary_network_info.subnets)
  name                 = var.primary_network_info.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.base.name
  virtual_network_name = azurerm_virtual_network.primary.name
  address_prefixes     = [var.primary_network_info.subnets[count.index].cidr]

  depends_on = [azurerm_virtual_network.primary]
}

# Secondary VNet
resource "azurerm_virtual_network" "secondary" {
  name                = var.secondary_network_info.name
  address_space       = [var.secondary_network_info.cidr]
  location            = var.resource_group_info.secondary_region
  resource_group_name = azurerm_resource_group.base.name

  depends_on = [azurerm_resource_group.base]

}

# Subnets
resource "azurerm_subnet" "secondary_subnets" {
    count                = length(var.secondary_network_info.subnets)
    name                 = var.secondary_network_info.subnets[count.index].name
    resource_group_name  = azurerm_resource_group.base.name
    virtual_network_name = azurerm_virtual_network.secondary.name
    address_prefixes     = [var.secondary_network_info.subnets[count.index].cidr]
    
    depends_on = [azurerm_virtual_network.secondary]
    }