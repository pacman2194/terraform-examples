# Availability set for when your static website goes viral?
# Availability sets ensure that the VMs you deploy on Azure are distributed across
# multiple isolated hardware clusters. Doing this ensures that if a hardware or software
# failure within Azure happens, only a subset of your VMs is impacted and that your overall
# solution remains available and operational.
resource "azurerm_availability_set" "webserver" {
  name                         = "${var.prefix}-avset-webserver"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

# TODO: Change this to azurerm_linux_virtual_machine_scale_set resource type
# configuration for your VMs serving up only the spiciest memes
resource "azurerm_linux_virtual_machine" "webserver" {
  count                            = var.webserver_count
  name                             = "${var.prefix}-vm-webserver-${count.index}"
  resource_group_name              = azurerm_resource_group.main.name
  location                         = azurerm_resource_group.main.location
  size                             = "Standard_B1s"

  admin_username                   = var.webserver_user
  disable_password_authentication  = true

  availability_set_id              = azurerm_availability_set.webserver.id

  network_interface_ids = [
    azurerm_network_interface.webserver[count.index].id,
  ]

  custom_data = base64encode(file("./init/webserver.sh"))

  admin_ssh_key {
    username   = var.webserver_user
    public_key = file(var.ssh_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
