terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""





}

resource "azurerm_resource_group" "example" {
  name     = var.resource_grp_name
  #location = "West Europe"
  location = var.location
}