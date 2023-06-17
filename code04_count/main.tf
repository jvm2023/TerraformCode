resource "azurerm_resource_group" "localrg" {
    name = "westeuroperg-${count.index}"
    location = var.location
    count = 3

  

}