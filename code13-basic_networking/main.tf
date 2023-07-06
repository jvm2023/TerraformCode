



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



resource "azurerm_network_security_group" "example5" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  depends_on          = [azurerm_resource_group.example1]

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Production"
  }
}


resource "azurerm_network_interface_security_group_association" "example6" {
  network_interface_id      = azurerm_network_interface.example4.id
  network_security_group_id = azurerm_network_security_group.example5.id
}

