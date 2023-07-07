locals {
  rg_name =   "${var.nameofrg}-prod"
  location = "West Europe"
  storageaccountinfo = {
# we can also use lower function to make sure all in lowercase
    nameofsa = join("",["${var.saname}",substr(random_uuid.forsaccount.result,0,6)])
    tier = "Standard"

  }
}

