resource "azurerm_resource_group" "localname1" {
  
  for_each = toset(var.names)
  name = "${each.key}-rg"
  location = each.value
  
}
