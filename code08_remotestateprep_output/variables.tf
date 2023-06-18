variable "resgrp_name" {
    type = string
    description = "name of resgrp"
  
}


variable "storageaccname" {
    type = string
    description = "storage account name"
  
}

variable "location" {
    type = string
    description = "location of resource group"
  
}


variable "stgacctier" {
    type = string
    description = "tier of stg account"
  
}

variable "stgaccreplication" {
    type = string
    description = "whether LRS or GRS or other"
  
}

variable "containername" {
    type = string
    description = "name of storagecontainer"
  
}

variable "containeraccesstype" {
    type = string
    description = "private or other"
  
}