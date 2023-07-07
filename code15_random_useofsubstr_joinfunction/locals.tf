locals {
  rg_name =   "${var.nameofrg}-prod"
  location = "West Europe"
  storageaccountinfo = {
    nameofsa = join("",["${var.saname}",substr(random_uuid.forsaccount.result,0,6)])
    tier = "Standard"

  }
}

