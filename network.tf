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

resource "azurerm_subnet" "subnetweb" {
  name                 = "subnetweb-${var.project}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]

  delegation {
    name = "webapp_delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "subnetfunction" {
  name                 = "subnetfunction-${var.project}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "subnetdb_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetdb.id
}

resource "azurerm_subnet_network_security_group_association" "subnetapp_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetapp.id
}

resource "azurerm_subnet_network_security_group_association" "subnetaweb_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetweb.id
}

resource "azurerm_subnet_network_security_group_association" "subnetfunction_association" {
  network_security_group_id = azurerm_network_security_group.netsecgroup.id
  subnet_id                 = azurerm_subnet.subnetfunction.id
}
