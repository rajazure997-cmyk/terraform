# =================================================
# FETCH ACTIVATED DIRECTORY ROLES
# =================================================

locals {
  role_name_to_object_id = {
    for role in data.azuread_directory_roles.all.roles :
    role.display_name => role.object_id
  }
}
