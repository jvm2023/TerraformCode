this code is used to deploy vnet with two subnets 
since vnets depend on resource group it will deploy resource group also 
variables defined in root module 
variable "rg_name" {
    type = string
    description = "rg name"
  
}
variable "location" {
    type = string
    description = "location"
  
}
variable "vnetname" {
    type = string
    description = "name of vnet"
  
}
variable "addressspace" {
    type = string
  
}
variable "subnets" {
    type = map
  
}


call the child module in main.tf like below
module "net_module" {
    source = "./netmodule"

    passin values of variables 



for creation of subnets seperate subnets block is used and 
for_each meta argument to create multiple subnets .
