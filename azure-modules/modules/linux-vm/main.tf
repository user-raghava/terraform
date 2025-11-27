# public ip 

resource "azurerm_public_ip" "primary_web" {
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  name                = var.public_ip_name

}

# Network interface

resource "azurerm_network_interface" "primary_web" {
  resource_group_name = var.resource_group_name
  location            = var.location
  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.primary_web.id
  }
  name = var.nic_name

}

# Linux VM
resource "azurerm_linux_virtual_machine" "primary_web" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.username

  network_interface_ids = [
    azurerm_network_interface.primary_web.id,
  ]
  admin_ssh_key {
    username   = var.username
    public_key = file(var.ssh_key_location)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
  # custom data for cloud-init
  custom_data = var.custom_data
}

# vm provisioner
resource "null_resource" "vm_provision" {
  triggers = {
    always_run = timestamp()
  }
  connection {
    type        = "ssh"
    host        = azurerm_public_ip.primary_web.ip_address
    user        = "dell"
    private_key = file("~/.ssh/id_ed25519")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt install tree -y"
    ]
  }
  depends_on = [azurerm_linux_virtual_machine.primary_web]
}

resource "azurerm_network_interface_security_group_association" "primary" {
  network_interface_id      = azurerm_network_interface.primary_web.id
  network_security_group_id = var.nsg_id

}
