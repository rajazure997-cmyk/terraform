# --- Provider Configuration and Versions ---
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.40" # Use a modern version for MS Graph API support
    }
  }
}

# Configure the Microsoft Azure Provider (for Azure Resources like Resource Group)
provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

# Configure the Microsoft Entra ID Provider (for Users and Roles)
provider "azuread" {} 

data "azuread_client_config" "current" {}

resource "azuread_group" "new_users" {
  display_name     = var.new_group_display_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group_member" "henry_remote_acces" {
  group_object_id  = azuread_group.new_users.object_id
  member_object_id = data.azuread_user.henry.object_id
}

data "azuread_user" "henry" {
  user_principal_name = var.new_user_upn
}

resource "azurerm_resource_group" "rg2" {
  name     = var.rgname
  location = var.rglocation
}

# 3. Create the role assignment
resource "azurerm_role_assignment" "henry_blob_reader" {
  scope                = data.azurerm_resource_group.rg2.id 
  role_definition_name = var.role_to_assign 
  principal_id         = data.azurerm_user.henry.object_id 
}