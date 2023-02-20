terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraformadmin"
    storage_account_name = "lterraformstorage"
    container_name       = "terraform-state"
  }
}