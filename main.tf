############################################
# ACTIVATE ENTRA DIRECTORY ROLES
############################################
resource "azuread_directory_role" "activate_roles" {
  for_each     = toset(local.entra_roles_to_activate)
  display_name = each.key
}

############################################
# ENTRA ACTIVE ROLE ASSIGNMENTS (NO PIM)
############################################
resource "azuread_directory_role_assignment" "entra_active" {

  depends_on = [
    azuread_directory_role.activate_roles
  ]

  for_each = local.entra_active

  role_id             = azuread_directory_role.activate_roles[each.value.role_name].object_id
  principal_object_id = each.value.principal_object_id
}

############################################
# ENTRA PIM ELIGIBLE ROLES (LICENSE-GATED)
############################################
resource "azuread_directory_role_eligibility_schedule_request" "entra_eligible" {

  for_each = var.enable_pim ? local.entra_eligible : {}

  role_definition_id = azuread_directory_role.activate_roles[each.value.role_name].object_id
  principal_id       = each.value.principal_object_id
  directory_scope_id = "/"

  justification = try(each.value.justification, "Terraform Eligible Assignment")
}

############################################
# AZURE RBAC ACTIVE ROLES
############################################
resource "azurerm_role_assignment" "rbac_active" {

  for_each = local.rbac_active

  scope                = each.value.scope
  role_definition_name = each.value.role_name
  principal_id         = each.value.principal_object_id
}

############################################
# AZURE RBAC PIM ELIGIBLE (LICENSE-GATED)
############################################
resource "azurerm_pim_eligible_role_assignment" "rbac_eligible" {

  for_each = var.enable_pim ? local.rbac_pim_eligible : {}

  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = each.value.principal_object_id

  justification = try(each.value.justification, "Terraform Eligible Assignment")
}

############################################
# AZURE RBAC PIM ACTIVE
############################################
resource "azurerm_pim_active_role_assignment" "rbac_pim_active" {

  for_each = local.rbac_pim_active

  scope              = each.value.scope
  role_definition_id = each.value.role_definition_id
  principal_id       = each.value.principal_object_id

  justification = try(each.value.justification, "Terraform Active Assignment")
}
