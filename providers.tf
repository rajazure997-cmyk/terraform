provider "azuread" {
  tenant_id = "40666927-43dd-4cdd-9ec3-74161a2f838e"
}



terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }

  }
}
