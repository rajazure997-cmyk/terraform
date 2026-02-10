############################################
# Activate required Entra roles
############################################
resource "azuread_directory_role" "activate_roles" {
  for_each     = toset(local.entra_roles_to_activate)
  display_name = each.key
}

############################################
# Assign roles to users
############################################
resource "azuread_directory_role_assignment" "entra_active" {

  depends_on = [azuread_directory_role.activate_roles]

  for_each = local.entra_active

  role_id = azuread_directory_role.activate_roles[each.value.role_name].object_id

  principal_object_id = each.value.principal_object_id
}
