terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=4.5.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7021a6a2-42bd-4f99-b2bb-3e2e89b8749e"
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