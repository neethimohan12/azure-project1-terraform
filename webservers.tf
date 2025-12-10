
resource "azurerm_network_interface" "web_vm_nic" {
  name                = var.web_network_interface
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-ipconfig"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web_vm" {
  name                = var.web_vm
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_sizes[0]
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.web_vm_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/awscad/azure-project1-terraform/azure_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    environment = "Production"
    tier        = "Web"
  }
}
