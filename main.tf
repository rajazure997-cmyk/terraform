# --- Provider Configuration and Versions ---
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.48.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  tenant_id = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
  subscription_id = "4edf8b82-34bd-4aa2-a2f3-9fdb7b1df5ad"
}

# Configure the Microsoft Entra ID Provider
provider "azuread" {
    tenant_id = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
} 

data "azuread_client_config" "current" {}

# --- 1. USER LOOKUP (Using azuread provider only) ---
# This data source is used to get the Object ID for the user's UPN.
data "azuread_user" "henry" {
  user_principal_name = var.new_user_upn
}

# --- 2. AZURE AD GROUP AND MEMBER ---
resource "azuread_group" "new_users" {
  display_name     = var.new_group_display_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group_member" "henry_remote_acces" {
  group_object_id  = azuread_group.new_users.object_id
  member_object_id = data.azuread_user.henry.object_id # References the user data source above
}

# --- 3. AZURE RESOURCE GROUP (Resource Creation) ---
resource "azurerm_resource_group" "rg2" {
  name     = var.rgname
  location = var.rglocation
}
resource "azuread_directory_role" "global_reader" {
  template_id = "f2ef992c-3afb-46b9-b7cf-a126ee74c451"
}
# 2. ASSIGN THE ROLE
# Now we reference the 'object_id' of the activated role above.
resource "azuread_directory_role_member" "henry_global_reader" {
  role_object_id   = azuread_directory_role.global_reader.object_id
  member_object_id = "ad0666a4-558a-410d-9050-4435e9ef8534" # user or SP object ID
}