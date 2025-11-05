## ----------------------------------------------------
## 4. Virtual Machine
## ----------------------------------------------------
resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.environment}${var.vm_name}-vm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_D2als_v6"
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]
  disable_password_authentication = true

  # OS Disk
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.vm_disk_size
  }

  # Image (Ubuntu 20.04 LTS)
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  # SSH Key Setup
  # Needed for Ansible and secure access
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }
}
