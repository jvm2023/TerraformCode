resource "azurerm_resource_group" "example" {
  name     = var.res_grp_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = ["192.168.1.0/24"]
  location            = var.location
  resource_group_name = var.res_grp_name
}

resource "azurerm_subnet" "example" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.res_grp_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["192.168.1.224/27"]
}

resource "azurerm_public_ip" "example" {
  name                = "examplepip"
  location            = var.location
  resource_group_name = var.res_grp_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = var.bastion_host
  location            = var.location
  resource_group_name = var.res_grp_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.example.id
    public_ip_address_id = azurerm_public_ip.example.id
  }
}
