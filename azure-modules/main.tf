resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.location.primary
}

module "primary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "primary-vnet"
    cidr     = "10.10.0.0/16"
    location = "centralindia"
  }
  vnet_subnets = [
    {
      name = "web"
      cidr = "10.10.0.0/24"
  }]
}

module "secondary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "secondary-vnet"
    cidr     = "10.11.0.0/16"
    location = var.location.secondary
  }
  vnet_subnets = [
    {
      name = "web"
      cidr = "10.11.0.0/24"
  }]
}

module "primary_web_nsg" {
  source              = "./modules/sg"
  resource_group_name = azurerm_resource_group.base.name
  location            = var.location.primary
  name                = "web_nsg_primary"
  rules = [{
    name                   = "openhttp"
    priority               = 300
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "80"
    destination_port_range = "80"
    access                 = "Allow"
    }, {
    name                   = "openssh"
    priority               = 310
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "22"
    destination_port_range = "22"
    access                 = "Allow"
  }]
  depends_on = [azurerm_resource_group.base]

}

module "secondary_web_nsg" {
  source              = "./modules/sg"
  resource_group_name = azurerm_resource_group.base.name
  location            = var.location.secondary
  name                = "web_nsg_secondary"
  rules = [{
    name                   = "openhttp"
    priority               = 300
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "80"
    destination_port_range = "80"
    access                 = "Allow"
    }, {
    name                   = "openssh"
    priority               = 310
    direction              = "Inbound"
    source_address_prefix  = "*"
    source_port_range      = "22"
    destination_port_range = "22"
    access                 = "Allow"
  }]
  depends_on = [azurerm_resource_group.base]

}