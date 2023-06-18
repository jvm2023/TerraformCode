terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraformstaterg_westeurope"
    storage_account_name = "terraformstatestgaccwe"
    container_name       = "tfstatecontainerwesteurope"
    key                  = "terraform.tfstate"


  }
}

provider "azurerm" {
  features {}

  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""





}