output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "snet_pep_id" {
  value = azurerm_subnet.s_pep.id
}
