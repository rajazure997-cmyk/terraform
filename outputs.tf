output "resource_group_id" {
  description = "The ID of the created Azure Resource Group."
  value       = azurerm_resource_group.rg1.id
}

output "new_user_object_id" {
  description = "The Object ID (GUID) of the newly created Microsoft Entra ID user."
  value       = azuread_user.new_user.object_id
}

output "new_user_upn" {
  description = "The User Principal Name (UPN) of the created user."
  value       = azuread_user.new_user.user_principal_name
}

output "directory_role_assignment_id" {
  description = "The ID of the Entra ID Directory Role assignment (e.g., Global Reader assignment)."
  # This output remains unchanged, assuming the resource is in main.tf
  value       = azuread_directory_role_assignment.user_role_assignment.id
}

output "azure_rbac_role_assignment_id" {
  description = "The ID of the Azure RBAC role assignment (e.g., Reader role on the Resource Group)."
  # This line assumes the resource name we used: new_user_rg_reader_role
  value       = azurerm_role_assignment.new_user_rg_reader_role.id
}