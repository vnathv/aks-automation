provider "azurerm" {
  features {}
}

terraform {
required_providers {
  azurerm = {
      source = "hashicorp/azurerm"
      version = "3.87.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "2.12.1"
    }
  }
  # required_providers {
  #   azurerm = {
  #     source = "hashicorp/azurerm"
  #     version = "3.83.0"
  #   }
  #   helm = {
  #     source = "hashicorp/helm"
  #     version = "2.12.1"
  #   }
  #   kubernetes = {
  #     source = "hashicorp/kubernetes"
  #     version = "2.24.0"
  #   }
  # }
}

