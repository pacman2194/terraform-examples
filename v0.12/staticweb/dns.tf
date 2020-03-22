# DNS zone
resource "azurerm_dns_zone" "main" {
  # conditionally use this resource by using count
  count = var.use_dns ? 1 : 0

  name                = var.dns_zone_name
  resource_group_name = azurerm_resource_group.main.name
}

# DNS alias record pointed to your load balancer via the public IP
resource "azurerm_dns_a_record" "main" {
  # conditionally use this resource by using count
  count = var.use_dns ? 1 : 0

  name                = "@"
  zone_name           = azurerm_dns_zone.main[0].name
  resource_group_name = azurerm_resource_group.main.name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.main.id
}

