#################################################################################################################
### Terraform Config
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
  backend "azurerm" {
    storage_account_name = "tfbackend1429761044sa"
    container_name       = "tfbackend1429761044cont"
    key                  = "dev/ePortfolio_frontend.tfstate"
    access_key           = ""
  }  
}
provider "azurerm" {
  features {}
}

### Terraform Config
#################################################################################################################