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


# --- Data Source: Retrieve Tenant ID ---

# This retrieves the Tenant ID of the identity running Terraform, 
# which is needed for the directory_scope_id.
data "azuread_client_config" "current" {}


resource "azuread_group" "new_users" {
  display_name     = var.new_group_display_name
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group_member" "henry" {
  group_object_id  = azuread_group.new_users.object_id
  member_object_id = data.azuread_client_config.current.object_id
}

data "azuread_user" "henry" {
  user_principal_name = var.new_user_upn
}
# # --- Local Variables: Directory Role Template ID Lookup ---

# locals {
#   # This block replaces the unsupported data source lookup for directory roles.
#   # We use the fixed Template ID (GUID) for built-in Entra ID roles.
#   directory_role_template_ids = {
#     "Global Reader"        = "f2ef992c-3afb-46b0-b747-50523e20e9a7" 
#     "User Administrator"   = "fe930be7-5e62-47db-91af-98c3a49a38b1" 
#     "Global Administrator" = "62e90394-69f5-4237-9190-012177145e10"
#     # Add other built-in roles here as needed
#   }
# }


# --- Azure Resource: Resource Group ---

# Creates the Azure Resource Group
resource "azurerm_resource_group" "rg2" {
  name     = var.rgname
  location = var.rglocation
}

# # --- Entra ID Resource: User Account ---

# # STEP 1: Create the new User Account in Entra ID
# resource "azuread_user" "new_user" {
#   user_principal_name = var.new_user_upn
#   display_name        = var.new_user_display_name
#   mail_nickname       = split("@", var.new_user_upn)[0]
  
#   # Set initial login credentials
#   password            = var.initial_password
#   force_password_change = true
#   account_enabled     = true 
# }

# data "azurerm_client_config" "current" {
# }

# resource "azurerm_role_assignment" "new_user_rg_reader_role" {
#   # SCOPE: The ID of the Resource Group created in the main.tf
#   scope                = azurerm_resource_group.rg1.id 
  
#   # ROLE DEFINITION: The Azure RBAC role to grant
#   role_definition_name = "Reader" 
  
#   # PRINCIPAL ID: The Object ID of the newly created Entra ID user
#   principal_id         = azuread_user.new_user.object_id
  
#   # DEPENDENCY: Ensures the user is fully created before the Azure RM provider attempts the assignment
#   depends_on = [
#     azuread_user.new_user
#   ]
# }
# # --- Entra ID Resource: Directory Role Assignment ---

# # STEP 2: Assign the Directory Role to the New User
# resource "azuread_directory_role_assignment" "user_role_assignment" {
#   # Role ID (UUID): Look up the GUID from the local map
#   role_id             = lookup(local.directory_role_template_ids, var.directory_role_name)

#   # Principal ID: The Object ID of the newly created user
#   principal_object_id = azuread_user.new_user.object_id

#   # Scope ID: The Tenant ID retrieved from the data source (FIX for previous error)
#   directory_scope_id  = data.azuread_client_config.current.tenant_id
  
#   # Ensure the role name provided is valid against our local map
#   lifecycle {
#     precondition {
#       condition     = contains(keys(local.directory_role_template_ids), var.directory_role_name)
#       error_message = "The role name '${var.directory_role_name}' is not a recognized built-in role in the local map. Please check spelling or update the map."
#     }
#   }
# }