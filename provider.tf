terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "2.2.0"
    }
    jinja = {
      source  = "NikolaLohinski/jinja"
      version = "2.4.2"
    }
  }
}