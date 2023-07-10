resource "azurerm_resource_group" "example" {
  name     = local.rgname
  location = local.loc
}



resource "azurerm_virtual_network" "example" {
  name                = local.v_name
  location            = local.loc
  resource_group_name = local.rgname
  address_space       = local.address
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  /*for_each = var.subnets

  subnet {
    name           = each.key
    address_prefix = each.value
  }
*/


  tags = {
    environment = "staging"
  }
  depends_on = [ azurerm_resource_group.example ]
}


resource "azurerm_subnet" "subnets" {
    for_each = var.subnets
    name = each.key
    resource_group_name = local.rgname
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes = [each.value]

depends_on = [ azurerm_resource_group.example, azurerm_virtual_network.example ]
  
}

