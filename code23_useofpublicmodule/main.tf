module "jenkins" {
  source  = "jvm2023/jenkins/azurerm"
  version = "1.0.0"
  # insert the 8 required variables here


location = "West Europe"
    
  


vnet_name = "jenkinsvnet"
    
  

vnet_addressspace = "10.0.0.0/16"
  
rg_name = "jenkinsrg"

subnet_name = "jenkins_subnet"
  


subnet_prefix = "10.0.2.0/24"


nicname = "jenkins_vmnic"
    



vmname = "jenkinsserver"




}

provider "azurerm" {
  features {
     resource_group {
     prevent_deletion_if_contains_resources = false    
     }
  }

 

subscription_id = 
client_id       =
client_secret   = 
tenant_id       = 
}