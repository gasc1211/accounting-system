resource "azurerm_network_security_group" "netsecgroup" {
  name                = "netsecgroup-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    "environment" = var.environment
    "project"     = var.project
    "created_by"  = "terraform"
  }
}

resource "azurerm_subnet" "subnetdb" {
  name                 = "subnetdb-${var.project}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnetapp" {
  name                 = "subnetapp-${var.project}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnetdb_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetdb.id
}

resource "azurerm_subnet_network_security_group_association" "subnetapp_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetapp.id
}
