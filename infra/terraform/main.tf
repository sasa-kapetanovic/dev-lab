resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

terraform {
  backend "azurerm" {}
}