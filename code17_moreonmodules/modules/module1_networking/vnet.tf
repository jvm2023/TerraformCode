
module "general" {
    source = ".././module2_general"
    rgname = "demoinwesteu"
    loc = "West Europe"
  
}



resource "azurerm_virtual_network" "example" {
  name                = var.vnetname
  location            = var.loc
  resource_group_name = module.general.rgwhole.name
  address_space       = [var.address_space]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    
  }

  depends_on = [ module.general.rgwhole ]

  
}


