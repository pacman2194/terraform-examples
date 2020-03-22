# main virtual network
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# subnet, using only one in this case
resource "azurerm_subnet" "main_subnet_1" {
  name                 = "${var.prefix}-subnet-1"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}

# static public IP so we can serve up some spicy memes
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

# network interfaces for our VMs
resource "azurerm_network_interface" "webserver" {
  count               = var.webserver_count
  name                = "${var.prefix}-nic-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.main_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# security group for our webservers
resource "azurerm_network_security_group" "webserver_sg" {
  name                = "${var.prefix}-webserver-sg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# rule to allow https traffic to our server
resource "azurerm_network_security_rule" "webserver_tls" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "tls"
  priority                    = 100
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "443"
  destination_address_prefix  = azurerm_subnet.main_subnet_1.address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.webserver_sg.name
}

# rule to allow http traffic to our server
resource "azurerm_network_security_rule" "webserver_http" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "http"
  priority                    = 101
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "80"
  destination_address_prefix  = azurerm_subnet.main_subnet_1.address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.webserver_sg.name
}

# REALLY BAD RULE TO ALLOW SSH TO OUR SERVER FROM ANYWHERE
resource "azurerm_network_security_rule" "webserver_ssh" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "ssh"
  priority                    = 1000
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "22"
  destination_address_prefix  = azurerm_subnet.main_subnet_1.address_prefix
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.webserver_sg.name
}

# associate network interface(s) with load balancer backend address pool to "attach" to load balancer
resource "azurerm_network_interface_backend_address_pool_association" "example" {
  count                   = var.webserver_count
  backend_address_pool_id = azurerm_lb_backend_address_pool.webserver.id
  ip_configuration_name   = "primary"
  network_interface_id    = element(azurerm_network_interface.webserver.*.id, count.index)
}

