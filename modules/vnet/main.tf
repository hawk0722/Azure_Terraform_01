# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.env}-${var.code}"
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = [var.cidr]
}

# Bastion Snet
resource "azurerm_subnet" "s_bas" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 1)]
}

# Application gateway Snet
resource "azurerm_subnet" "s_agw" {
  name                 = "snet-agw-${var.env}-${var.code}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 2)]
}

# Private endpoint Snet
resource "azurerm_subnet" "s_pep" {
  name                 = "snet-pep-${var.env}-${var.code}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 3)]

  enforce_private_link_endpoint_network_policies = true
}

# Public Snet
resource "azurerm_subnet" "s_pub" {
  name                 = "snet-pub-${var.env}-${var.code}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 4)]
}

# Private Snet
resource "azurerm_subnet" "s_pri" {
  name                 = "snet-pri-${var.env}-${var.code}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 8, 5)]
}
