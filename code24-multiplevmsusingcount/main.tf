module "anything" {
    source = "./multiplevms"

rg_name           = "westeurope2"
location          = "West Europe"
vnet_name         = "devvnetwesteu2"
subnet_name       = "devsubnetwesteu2"
vnet_addressspace = "10.0.0.0/16"
subnet_prefix     = "10.0.2.0/24"
nicname           = "westeunic"
vmname            = "anythingwesteu"
numberofvms       =  3



  
}


