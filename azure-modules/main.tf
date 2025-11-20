resource "azurerm_resource_group" "base" {
  name     = var.resource_group_name
  location = var.primary_location
}

module "primary_vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.base.name
  network_info = {
    name     = "primary-vnet"
    cidr     = "10.10.0.0/16"
    location = "centralindia"
  }
  public_subnets = [
    {
      name = "web"
      cidr = "10.10.0.0/24"
    },
    {
      name = "app"
      cidr = "10.10.1.0/24"
    },
    {
      name = "db"
      cidr = "10.10.2.0/24"
  }]
}