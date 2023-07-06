locals {
  rg_name     = "prodrgwesteurope"
  rg_location = "West Europe"
  vnet_info = {
    name               = "prodwesteuropenetwork"
    address_space_vnet = ["10.0.0.0/16"]
  }
}

resource "azurerm_resource_group" "example" {
  name     = local.rg_name
  location = local.rg_location
}

resource "azurerm_virtual_network" "example" {
  name                = local.vnet_info.name
  address_space       = local.vnet_info.address_space_vnet
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  depends_on = [
    azurerm_resource_group.example
  ]
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = local.rg_name
  virtual_network_name = local.vnet_info.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [ azurerm_virtual_network.example ]
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic-${count.index}"
  location            = local.rg_location
  resource_group_name = local.rg_name
  count               = 2

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = local.rg_name
  location            = local.rg_location
  size                = "Standard_A1_v2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.example[0].id,
    azurerm_network_interface.example[1].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}