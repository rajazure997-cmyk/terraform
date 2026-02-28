data "azuread_client_config" "current" {}

data "azuread_directory_roles" "all" {
  depends_on = [azuread_directory_role.activate_roles]
}

data "azuread_application_published_app_ids" "well_known" {}

# =================================================
# Application Owners (UPN → Object ID)
# =================================================
data "azuread_user" "owners" {
  for_each            = toset(var.app_owners)
  user_principal_name = each.value
}

# =================================================
# Microsoft Graph (Dynamic – for App Registration)
# =================================================

data "azuread_service_principal" "microsoft_graph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}


