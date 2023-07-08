
variable "rgname" {
    type = string
    default = "westeudemorg"
  
}
  

  
  

  locals {

    resgrpname = "${var.rgname}-prod"
    location = "West Europe"
    storageaccountinfo = {
        name = "westeusa9876540datalake"
        accounttier = "Standard"
        replication = "GRS"
    }
    
  }
  
  
  
  
  
  
  
  
  
  resource "azurerm_resource_group" "example1" {
  name     = local.resgrpname
  location = local.location
}

resource "azurerm_storage_account" "example2" {
  name                     = local.storageaccountinfo.name
  resource_group_name      = local.resgrpname
  location                 = local.location
  account_tier             = local.storageaccountinfo.accounttier
  account_replication_type = local.storageaccountinfo.replication
  is_hns_enabled = true
depends_on = [ azurerm_resource_group.example1 ]

  tags = {
    environment = "prod"
  }
}
