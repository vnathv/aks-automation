data "azurerm_virtual_network" "vnet_data_source" {
  name                = "vijay-aks-vnet"
  resource_group_name = azurerm_resource_group.rg.name
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.vnet_data_source.id
}

output "virtual_network_name" {
  value = data.azurerm_virtual_network.vnet_data_source.name
}