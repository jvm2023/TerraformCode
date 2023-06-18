resource "azurerm_resource_group" "localname1" {
  
  for_each = var.names
  name = "${each.key}-rg"
  location = each.value
  
}