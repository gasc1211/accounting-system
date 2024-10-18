resource "azurerm_application_insights" "app_insights" {
  name                = "appinsights-${var.project}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  application_type    = "web"
}

output "instrumentation_key" {
  value     = azurerm_application_insights.app_insights.instrumentation_key
  sensitive = true
}

output "app_id" {
  value     = azurerm_application_insights.app_insights.app_id
  sensitive = true
}
