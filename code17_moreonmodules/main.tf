module "general" {
    source = "./modules/module2_general"
    rgname = "demoinwesteu"
    loc = "West Europe"



  
}




module "networkig" {
    source = "./modules/module1_networking"
    vnetname = "demonetwork1234"
    address_space = "10.0.0.0/16"
    loc = "West Europe"

  
}




