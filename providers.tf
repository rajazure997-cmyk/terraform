provider "azuread" {
  tenant_id = "40666927-43dd-4cdd-9ec3-74161a2f838e"
  client_id = "f182b68e-8a47-45c1-a04a-6ed71cdd1916"
  client_secret = var.client_secret
}

provider "azurerm" {
  features {}
    tenant_id = "40666927-43dd-4cdd-9ec3-74161a2f838e"
    client_id = "f182b68e-8a47-45c1-a04a-6ed71cdd1916"
    client_secret = var.client_secret
    subscription_id = "af675ebe-9f6b-4113-938e-819e5a56407c"

}



terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }
}
