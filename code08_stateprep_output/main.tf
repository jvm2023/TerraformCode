resource "azurerm_resource_group" "example" {
  name     = var.resgrp_name
  location = var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.storageaccname
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.stgacctier
  account_replication_type = var.stgaccreplication

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = var.containername
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = var.containeraccesstype
}