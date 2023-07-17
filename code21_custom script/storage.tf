resource "azurerm_storage_account" "strorageaccforcustom1234" {
  name                     = "strorageaccforcustom1234"
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.example ]

  
}

resource "azurerm_storage_container" "example" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.strorageaccforcustom1234.name
  container_access_type = "private"
  depends_on = [ azurerm_storage_account.strorageaccforcustom1234 ]
}


resource "azurerm_storage_blob" "defi" {
  name                   = "defi.ps1"
  storage_account_name   = azurerm_storage_account.strorageaccforcustom1234.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "defi.ps1"
  depends_on = [ azurerm_storage_account.strorageaccforcustom1234,azurerm_storage_container.example ]



}
/*
resource "azurerm_virtual_machine_extension" "vmextension" {
  name                 = "vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.example.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.strorageaccforcustom1234.name}.blob.core.windows.net/vhds/defi.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File defi.ps1"     
    }
SETTINGS
Microsoft.Compute/virtualMachines/extensions

}*/

