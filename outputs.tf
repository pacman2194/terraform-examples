output "rg_location" {
  value = "${azurerm_resource_group.main.location}"
}

output "public_ip" {
  value = "${azurerm_public_ip.main.ip_address}"
}
