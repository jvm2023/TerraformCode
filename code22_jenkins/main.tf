module "anything" {
    source = "./jenkins"


    rg_name = "jenkinsrg"
    



location = "West Europe"
    
  


vnet_name = "jenkinsvnet"
    
  

vnet_addressspace = "10.0.0.0/16"
  


subnet_name = "jenkins_subnet"
  


subnet_prefix = "10.0.2.0/24"


nicname = "jenkins_vmnic"
    



vmname = "jenkinsserver"


    









  
}