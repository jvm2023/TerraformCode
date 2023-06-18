resource "azurerm_resource_group" "example1" {
  name     = var.resgrp_name
  location = var.loc
}

resource "azurerm_network_security_group" "example2" {
  name                = var.network_sec_grp
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
}

resource "azurerm_virtual_network" "example3" {
  name                = var.vnet_name
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name
  address_space       = ["10.0.0.0/16"]

}