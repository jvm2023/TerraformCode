#here we will configure backend to azure storage account which has locking capability also
#we will be using output values from code08
backend block to be declared inside terraform block
 backend "azurerm" {
    resource_group_name   = "terraform-storage-rg"
    storage_account_name  = "terraformstate201"
    container_name        = "tfstatefiles"
    key                   = "terraform.tfstate"
  }
  
