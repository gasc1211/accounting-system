
provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg" {
  name = "rg-accounting_system-dev"
  location = "East US 2"
  tags = {
    "environment" = "dev"
    "project" = "accounting_system"
    "created_by" = "terraform"
  }
}