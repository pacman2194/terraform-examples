# availability set for when your static website goes viral?
resource "azurerm_availability_set" "webserver" {
  name                         = "${var.prefix}-avset-webserver"
  location                     = "${azurerm_resource_group.main.location}"
  resource_group_name          = "${azurerm_resource_group.main.name}"
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

# configuration for your VMs serving up only the spiciest memes
resource "azurerm_virtual_machine" "webserver" {
  count                           = "${var.webserver_count}"
  name                            = "${var.prefix}-vm-webserver-${count.index}"
  resource_group_name             = "${azurerm_resource_group.main.name}"
  location                        = "${azurerm_resource_group.main.location}"
  vm_size                         = "Standard_B1s"
  delete_os_disk_on_termination   = true
  delete_data_disks_on_termination = true
  # admin_username                  = "${var.webserver_user}"
  # admin_password                  = "${var.webserver_pass}"
  availability_set_id             = "${azurerm_availability_set.webserver.id}"
  # disable_password_authentication = true
  # network_interface_ids = [
  #   "${azurerm_network_interface.webserver[count.index].id}",
  # ]
  network_interface_ids = [
    "${azurerm_network_interface.webserver.id}",
  ]

  # admin_ssh_key {
  #   username   = "${var.webserver_user}"
  #   public_key = "${file("~/.ssh/id_rsa.pub")}"
  # }
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    name              = "osdisk${count.index}"
  }
  os_profile {
    computer_name  = "host${count.index}"
    admin_username = "${var.webserver_user}"
    admin_password = "${var.webserver_pass}"
    custom_data    = "${file("./init/webserver.sh")}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys = {
      key_data = "${file("${var.ssh_key_path}")}"
      # key_data = "${file("~/.ssh/id_rsa.pub")}"
      path     = "/home/${var.webserver_user}/.ssh/authorized_keys"
    }
  }
}
