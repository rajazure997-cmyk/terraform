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

output "role_assignment_id" {
  description = "The ID of the Entra ID directory role assignment."
  value       = azuread_directory_role_assignment.user_role_assignment.id
}