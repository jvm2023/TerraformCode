resource "azurerm_resource_group" "demo" {
    name = var.res_grp_name
    location = var.location
  
}

resource "azurerm_virtual_network" "myvnet" {
    name = "demovnetwesteurope"
    resource_group_name = azurerm_resource_group.demo.name
    location = azurerm_resource_group.demo.location
    address_space = ["10.0.0.0/16"]
  
}

resource "azurerm_subnet" "mysubnet" {
    name = "subnet1we"
    resource_group_name = azurerm_resource_group.demo.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes = ["10.0.2.0/24"]
  
}

resource "azurerm_public_ip" "publicipswe" {
  for_each = toset(var.vms)
  allocation_method = "Static"
  location = azurerm_resource_group.demo.location
  name = "publicip-${each.key}"
  resource_group_name = azurerm_resource_group.demo.name

}

resource "azurerm_network_interface" "mynics" {
    for_each = toset(var.vms)
    name = "vmnic-${each.key}"
    location = azurerm_resource_group.demo.location
    resource_group_name = azurerm_resource_group.demo.name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.mysubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicipswe[each.key].id
  }
  
}


resource "azurerm_windows_virtual_machine" "winvm" {
    for_each = azurerm_network_interface.mynics
    name = "winvmwe-${each.key}"
    location = azurerm_resource_group.demo.location
    network_interface_ids = [azurerm_network_interface.mynics[each.key].id]
    admin_username = "adminuser"
    admin_password = "P@$$w0rd1234!"
    size = "Standard_F2"
    resource_group_name = azurerm_resource_group.demo.name
    os_disk {
      name = "osdisk${each.key}"
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
