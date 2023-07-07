resource "random_uuid" "forsaccount" {
  

}


output "randomuid" {
    value = substr(random_uuid.forsaccount.result,0,6)
  
}




resource "azurerm_resource_group" "example" {
  name     = local.rg_name
  location = local.location
}

resource "azurerm_storage_account" "example" {
  name                     = local.storageaccountinfo.nameofsa
  resource_group_name      = local.rg_name
  location                 = local.location
  account_tier             = local.storageaccountinfo.tier
  account_replication_type = "GRS"
  depends_on = [ azurerm_resource_group.example,random_uuid.forsaccount ]

  tags = {
    environment = "prod"
  }
}




