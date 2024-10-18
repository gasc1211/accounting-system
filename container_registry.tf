resource "azurerm_service_plan" "app_service_plan" {
  name                = "asp-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  os_type  = "Linux"
  sku_name = "B1"

  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.projectdashless}${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

  tags = var.tags
}
