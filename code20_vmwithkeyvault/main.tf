resource "azurerm_resource_group" "example" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = [var.vnet_addressspace]
  location            = var.location
  resource_group_name = var.rgname
  depends_on = [ azurerm_resource_group.example ]
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.rgname
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_address_prefix]
  depends_on = [ azurerm_resource_group.example,azurerm_virtual_network.example ]
}

resource "azurerm_network_interface" "example" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.rgname

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
    
  }
  depends_on = [ azurerm_subnet.example ]
}
#use of data block to fetch alreay existing resource(key vault ) in cloud into terraform 
data "azurerm_key_vault" "westeukeyvault001" {
  name                = "westeukeyvault001"
  resource_group_name = "westeurg"
}


data "azurerm_key_vault_secret" "passwordofvm" {
  name         = "passwordofvm"
  key_vault_id = data.azurerm_key_vault.westeukeyvault001.id
}





resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = var.rgname
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = data.azurerm_key_vault_secret.passwordofvm.value
  network_interface_ids = [
    azurerm_network_interface.example.id,
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
  tags = {
    env = "staging"
  }
}




resource "azurerm_public_ip" "example" {
  name                = "publicipforvm"
  resource_group_name = var.rgname
  location            = var.location
  allocation_method   = "Static"
  depends_on = [ azurerm_resource_group.example ]

  tags = {
    env = "staging"
  }
}


#code for loganalytics workspace 
resource "azurerm_log_analytics_workspace" "example" {
  name                = "westeuwsforupdate"
  location            = var.location
  resource_group_name = var.rgname
  sku                 = "PerGB2018"
  retention_in_days   = 30
  depends_on = [ azurerm_resource_group.example ]
}

#code for automation account 

resource "azurerm_automation_account" "example" {
  name                = "automationaccfor-updates"
  location            = var.location
  resource_group_name = var.rgname
  sku_name            = "Basic"
  depends_on = [ azurerm_resource_group.example ]

  tags = {
    env = "staging"
  }
  
}



