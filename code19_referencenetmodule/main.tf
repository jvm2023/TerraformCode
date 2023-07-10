module "net_module" {
    source = "./netmodule"

    rg_name = "rgstagingwesteu"
location = "West Europe"


vnetname = "stagingvnetwesteu"


addressspace = "10.0.0.0/16"

subnets = {
    websubnet = "10.0.1.0/24"
    dbsubnet = "10.0.2.0/24"
}
  
}