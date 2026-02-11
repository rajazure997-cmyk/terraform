locals {

  assignments_flat = flatten([
    for user_key, user_data in var.entra_role_assignments : [
      for role in user_data.roles : {
        key                 = "${user_key}-${role}"
        principal_object_id = user_data.principal_object_id
        role_name           = role
      }
    ]
  ])

  entra_roles_to_activate = distinct([
    for a in local.assignments_flat :
    a.role_name
  ])

  entra_active = {
    for a in local.assignments_flat :
    a.key => a
  }

}


output "debug_assignments" {
  value = local.assignments_flat
}