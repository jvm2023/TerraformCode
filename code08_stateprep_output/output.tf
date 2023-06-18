output "resourcegrpname" {
    value = azurerm_resource_group.example1.name
    # value to be calculated based on local value
  
}

output "strgaccountname" {
    value = azurerm_storage_account.example2.name
  
}

output "stgcontainername" {
    value = azurerm_storage_container.example3.name
  
}