resource "azurerm_mssql_server" "sql_server"{
  name = "sqlserver-accounting-system-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  version = "12.0"
  location = var.location
  
  administrator_login = "sqladmin"
  administrator_login_password = var.sql_server_password

  tags = var.tags
}

resource "azurerm_mssql_database" "sql_db" {
  name = "sql_db-${var.project}-${var.environment}"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name = "S0"

  tags = var.tags
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name = "sql_private_endpoint-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id = azurerm_subnet.subnetdb.id
  location = var.location

  private_service_connection {
    name = "sql_private_endpoint_connection-${var.project}-${var.environment}"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names = [ "sql_server"]
    is_manual_connection = false
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = "private.dbserver.database.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
 
  tags = var.tags
}

resource "azurerm_private_dns_a_record" "privatedns_sqlserver_record" {
  name = "privatedns_sqlserver_record-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name = azurerm_private_dns_zone.private_dns_zone.name
  ttl = 300

  records = [ azurerm_private_endpoint.sql_private_endpoint.private_service_connection[0].private_ip_address ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  name = "db_vnet_link-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}