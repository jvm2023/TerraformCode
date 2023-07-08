resource "random_uuid" "forsaccount" {
  

}


output "randomuid" {
    value = substr(random_uuid.forsaccount.result,0,6)
  
}






resource "azurerm_resource_group" "example1" {
  name     = var.rgname
  location = var.location
}

resource "azurerm_storage_account" "example2" {
  name                     = join("",["${var.saprefix}",substr(random_uuid.forsaccount.result,0,6)])
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.accounttier
  account_replication_type = var.accountreplication
  is_hns_enabled = true

  depends_on = [ random_uuid.forsaccount,azurerm_resource_group.example1 ]

  tags = {
    environment = "staging"
  }
}




