terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = "226f7fa5-3371-4517-bc3c-cd266621af95"
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project}-${var.environment}"
  location = var.location
  tags     = var.tags
}
