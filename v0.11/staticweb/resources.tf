# resource group that will be used for all the resources in this project
resource "azurerm_resource_group" "main" {
  name     = "${var.resource_group}"
  location = "${var.location}"
}
