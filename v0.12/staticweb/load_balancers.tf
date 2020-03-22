# the load balancer you always wanted
resource "azurerm_lb" "webserver" {
  name                = "${var.prefix}-lb-webserver"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  # Public IP should route to the load balancer which balances traffic to your VMs
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

# route http traffic to the webserver backend address pool
resource "azurerm_lb_rule" "webserver_http" {
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.webserver.id
  name                           = "${var.prefix}-lb-rule-http"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_id        = azurerm_lb_backend_address_pool.webserver.id
  frontend_ip_configuration_name = "PublicIPAddress"
}

# route https traffic to the webserver backend address pool
resource "azurerm_lb_rule" "webserver_https" {
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.webserver.id
  name                           = "${var.prefix}-lb-rule-https"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  backend_address_pool_id        = azurerm_lb_backend_address_pool.webserver.id
  frontend_ip_configuration_name = "PublicIPAddress"
}

# route ssh traffic to the webserver backend address pool
# NOTE: THIS IS NOT ADVISABLE AND I RECOMMEND SETTING UP SOME TYPE OF JUMP BOX TO ACCESS YOUR OTHER SERVERS
resource "azurerm_lb_rule" "webserver_ssh" {
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.webserver.id
  name                           = "${var.prefix}-lb-rule-ssh"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.webserver.id
  frontend_ip_configuration_name = "PublicIPAddress"
}

# backend address pool for webservers, network interfaces associate with this to "attach" VMs, etc. to the load balancer
resource "azurerm_lb_backend_address_pool" "webserver" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.webserver.id
  name                = "${var.prefix}-lb-beap"
}

