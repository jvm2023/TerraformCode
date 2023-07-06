locals {
  rg_name        = "testrgwesteurope01"
  loc            = "West Europe"
  stgaccountname = "unique3780987"
  containerinfo = {
    name       = "data"
    accesstype = "private"
  }

}

resource "azurerm_resource_group" "demo1" {
  name     = local.rg_name
  location = local.loc


}



resource "azurerm_storage_account" "demo2" {
  name                     = local.stgaccountname
  resource_group_name      = local.rg_name
  location                 = local.loc
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
  depends_on = [azurerm_resource_group.demo1]
}


resource "azurerm_storage_container" "demo3" {
  name                  = "${local.containerinfo.name}-${count.index}"
  storage_account_name  = local.stgaccountname
  container_access_type = local.containerinfo.accesstype
  count                 = 3
  depends_on = [ azurerm_storage_account.demo2 ]
}


