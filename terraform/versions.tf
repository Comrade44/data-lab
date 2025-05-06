terraform {
  required_version = ">= 1.11.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.27.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.arm_subscription_id
  features {}
}