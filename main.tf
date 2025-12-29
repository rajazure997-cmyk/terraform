# =================================================
# Provider Configuration and Versions
# =================================================
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

# =================================================
# Azure Provider
# =================================================
provider "azurerm" {
  features {}
  tenant_id       = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
  subscription_id = "4edf8b82-34bd-4aa2-a2f3-9fdb7b1df5ad"
}

# =================================================
# Azure AD Provider
# =================================================
provider "azuread" {
  tenant_id = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
}

data "azuread_client_config" "current" {}

# =================================================
# USER LOOKUP
# =================================================
data "azuread_user" "henry" {
  user_principal_name = var.new_user_upn
}

# =================================================
# AZURE AD GROUP + MEMBER
# =================================================
resource "azuread_group" "new_users" {
  display_name     = var.new_group_display_name
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group_member" "henry_remote_access" {
  group_object_id  = azuread_group.new_users.object_id
  member_object_id = data.azuread_user.henry.object_id
}

# =================================================
# AZURE RESOURCE GROUP
# =================================================
resource "azurerm_resource_group" "rg2" {
  name     = var.rgname
  location = var.rglocation
}

# =================================================
# DIRECTORY ROLE (Reports Reader)
# =================================================
resource "azuread_directory_role" "reports_reader" {
  template_id = "4a5d8f65-41da-4de4-8968-e035b65339cf"
}

resource "azuread_directory_role_member" "henry_reports_reader" {
  role_object_id   = azuread_directory_role.reports_reader.object_id
  member_object_id = data.azuread_user.henry.object_id
}

# =================================================
# APPLICATION REGISTRATION (FIXED)
# =================================================
resource "azuread_application" "app" {
  display_name = var.app_display_name
  owners       = var.app_owners

  dynamic "required_resource_access" {
    for_each = var.api_permissions
    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }
}

# =================================================
# SERVICE PRINCIPAL
# =================================================
resource "azuread_service_principal" "app_sp" {
  client_id = azuread_application.app.client_id
  owners    = var.app_owners
}
