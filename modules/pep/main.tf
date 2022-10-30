# Create Private DNS Zone
resource "azurerm_private_dns_zone" "pdns_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.rg_name
}

# Create Private DNS Zone Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name                  = "vnl-${azurerm_private_dns_zone.pdns_blob.name}"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.pdns_blob.name
  virtual_network_id    = var.vnet_id
}

# Create Private Endpint
resource "azurerm_private_endpoint" "pep" {
  name                = "pep-${var.env}-${var.code}"
  resource_group_name = var.rg_name
  location            = var.location
  subnet_id           = var.snet_pep_id
  private_service_connection {
    name                           = "psc-${var.env}-${var.code}"
    private_connection_resource_id = var.st_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

# Create DNS A Record
resource "azurerm_private_dns_a_record" "pdns_a" {
  name                = var.st_name
  zone_name           = azurerm_private_dns_zone.pdns_blob.name
  resource_group_name = var.rg_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pep.private_service_connection.0.private_ip_address]
}
