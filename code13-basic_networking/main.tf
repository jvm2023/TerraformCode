



resource "azurerm_resource_group" "example1" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example2" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  depends_on          = [azurerm_resource_group.example1]
}

resource "azurerm_subnet" "example3" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.example2.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on           = [azurerm_virtual_network.example2]
}

resource "azurerm_public_ip" "example5" {
  name                = "prodpublicip1"
  resource_group_name = azurerm_resource_group.example1.name
  location            = azurerm_resource_group.example1.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface" "example4" {
  name                = "example-nic"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  depends_on          = [azurerm_subnet.example3, azurerm_resource_group.example1]

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example5.id
  }
}



