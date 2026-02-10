# locals {

#   assignments = var.entra_role_assignments

#   entra_roles_to_activate = distinct([
#     for a in local.assignments :
#     a.role_name
#   ])

#   entra_active = {
#     for idx, a in local.assignments :
#     "${a.principal_object_id}-${a.role_name}" => a
#   }

# }

locals {

  assignments_flat = flatten([
    for p in var.entra_role_assignments : [
      for r in p.roles : {
        principal_object_id = p.principal_object_id
        role_name           = r
      }
    ]
  ])

  entra_roles_to_activate = distinct([
    for a in local.assignments_flat :
    a.role_name
  ])

  entra_active = {
    for a in local.assignments_flat :
    "${a.principal_object_id}-${a.role_name}" => a
  }

}



output "debug_assignments" {
  value = local.assignments_flat
}