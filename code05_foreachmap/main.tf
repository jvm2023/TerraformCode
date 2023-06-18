resource "azurerm_resource_group" "localname1" {
  
  for_each = var.locations
  name = "${each.key}-rg"
  location = each.value
  
}