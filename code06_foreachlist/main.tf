resource "azurerm_resource_group" "localname1" {
  
<<<<<<< HEAD
  for_each = var.names
=======
  for_each = toset(var.names)
>>>>>>> 14b0af6d46bf239d474921abc2ff35683a2a2039
  name = "${each.key}-rg"
  location = each.value
  
}
