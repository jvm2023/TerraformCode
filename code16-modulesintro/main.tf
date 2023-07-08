# name of module can be anything
#however when we call child module we need to provide exact child name
#values of variables defined should be given in module block only
module "datalake_module" {
  source = "./datalakesa"






rgname = "westeudemo"


saprefix = "westeudemo"

location    = "West Europe"
accounttier = "Standard"

accountreplication = "GRS"



}