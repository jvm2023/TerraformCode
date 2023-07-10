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