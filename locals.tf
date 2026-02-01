

  #################################
  # Load Assignments JSON Safely
  #################################
locals {
  assignments = jsondecode(file(var.assignments_file))

  #################################
  # Entra Active Roles
  #################################

  entra_active = {
    for a in local.assignments :
    a.key => a
    if try(a.kind, "") == "entra_directory_role" &&
       try(a.mode, "") == "active"
  }

  #################################
  # Entra PIM Eligible Roles
  #################################

  entra_eligible = {
    for a in local.assignments :
    a.key => a
    if try(a.kind, "") == "entra_directory_role" &&
       try(a.mode, "") == "eligible"
  }

  #################################
  # RBAC Active Roles
  #################################

  rbac_active = {
    for a in local.assignments :
    a.key => a
    if try(a.kind, "") == "rbac" &&
       try(a.mode, "") == "active"
  }

  #################################
  # RBAC PIM Eligible
  #################################

  rbac_pim_eligible = {
    for a in local.assignments :
    a.key => a
    if try(a.kind, "") == "rbac" &&
       try(a.mode, "") == "eligible"
  }

  #################################
  # RBAC PIM Active
  #################################

  rbac_pim_active = {
    for a in local.assignments :
    a.key => a
    if try(a.kind, "") == "rbac" &&
       try(a.mode, "") == "pim_active"
  }

  #################################
  # Roles To Activate
  #################################

  entra_roles_to_activate = distinct([
    for a in local.assignments :
    a.role_name
    if try(a.kind, "") == "entra_directory_role"
  ])

}


output "debug_assignments" {
  value = local.assignments
}