# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
#   subscription_id = var.azure_subscription_id
}

# Create a resource group
resource "azurerm_resource_group" "rg1" {
  name     = "${var.rgname}"
  location = "${var.rglocation}"
}

# Create a virtual network within the resource group
# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   address_space       = ["10.0.0.0/16"]
# }
# Configure the Microsoft Entra ID Provider
# It will automatically use the ARM_* environment variables from your TFC workspace
provider "azuread" {} 

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

# --- STEP 2: Lookup the Directory Role ---
data "azuread_directory_role" "target_role" {
  display_name = var.directory_role_name
}

# --- STEP 3: Assign the Directory Role to the New User ---
resource "azuread_directory_role_assignment" "user_role_assignment" {
  # The ID of the role template
  role_id             = data.azuread_directory_role.target_role.template_id

  # The Object ID of the newly created user (the principal)
  principal_object_id = azuread_user.new_user.object_id

  # The scope is the entire Entra ID tenant
  directory_scope_id  = azuread_user.new_user.tenant_id
}