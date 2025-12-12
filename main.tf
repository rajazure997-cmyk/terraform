# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
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

# --- Providers Configuration ---

# Configure the Microsoft Azure Provider (for Resource Groups)
provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

# Configure the Microsoft Entra ID Provider (for Users and Roles)
provider "azuread" {} 


# --- Local Variables (Role ID Fix) ---

locals {
  # This section replaces the unsupported data "azuread_directory_role" lookup.
  # We use the fixed Template ID (GUID) for built-in Entra ID roles.
  directory_role_template_ids = {
    "Global Reader"        = "f2ef992c-3afb-46b0-b747-50523e20e9a7" # Template ID for Global Reader
    "User Administrator"   = "fe930be7-5e62-47db-91af-98c3a49a38b1" # Template ID for User Administrator
    "Global Administrator" = "62e90394-69f5-4237-9190-012177145e10" # Template ID for Global Administrator
    # Add other built-in roles here as needed
  }
}


# --- Azure Resource Group ---

# Create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = var.rgname
  location = var.rglocation
}


# --- Entra ID Resources ---

# --- STEP 1: Create the User Account ---
resource "azuread_user" "new_user" {
  user_principal_name = var.new_user_upn
  display_name        = var.new_user_display_name
  mail_nickname       = split("@", var.new_user_upn)[0]
  
  # Set initial login credentials
  password            = var.initial_password
  force_password_change = true
  
  # Account must be enabled to be assigned a role
  account_enabled     = true 
}

# --- STEP 2: Lookup the Directory Role (REMOVED and replaced by locals) ---
/*
The following block was removed because it is invalid in current azuread provider versions:
data "azuread_directory_role" "target_role" {
  display_name = var.directory_role_name
}
*/

# --- STEP 3: Assign the Directory Role to the New User ---
resource "azuread_directory_role_assignment" "user_role_assignment" {
  # The ID of the role template - NOW REFERENCED VIA THE LOCAL VARIABLE
  role_id             = lookup(local.directory_role_template_ids, var.directory_role_name)

  # The Object ID of the newly created user (the principal)
  principal_object_id = azuread_user.new_user.object_id

  # The scope is the entire Entra ID tenant
  directory_scope_id  = azuread_user.new_user.tenant_id
  
  # Ensure the role name provided is valid against our local map
  lifecycle {
    precondition {
      condition     = contains(keys(local.directory_role_template_ids), var.directory_role_name)
      error_message = "The role name '${var.directory_role_name}' is not a recognized built-in role in the local map. Please check spelling or update the map."
    }
  }
}