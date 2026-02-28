# =================================================
# CREATE USER (Terraform-managed)
# =================================================
resource "azuread_user" "user" {
  user_principal_name   = var.new_user_upn
  display_name          = var.new_user_display_name
  mail_nickname         = var.new_user_mail_nickname
  password              = var.initial_password
  force_password_change = true
  account_enabled       = true
}

# =================================================
# Azure AD Group + Membership
# =================================================
resource "azuread_group" "new_users" {
  display_name     = var.new_group_display_name
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]
}

resource "azuread_group_member" "user_member" {
  group_object_id  = azuread_group.new_users.object_id
  member_object_id = azuread_user.user.object_id
}

#
# =================================================
# ACTIVATE REQUIRED ENTRA ID ROLES (IDEMPOTENT)
# =================================================
resource "azuread_directory_role" "activate_roles" {
  for_each     = toset(var.entra_roles)
  display_name = each.key
}


# =================================================
# ASSIGN ROLES TO USER (Provision / De-Provision)
# =================================================
resource "azuread_directory_role_assignment" "user_roles" {
  for_each = toset(var.entra_roles)

  role_id             = local.role_name_to_object_id[each.key]
  principal_object_id = azuread_user.user.object_id
}

# =================================================
# Azure AD Application
# =================================================
resource "azuread_application" "app" {
  display_name = var.app_display_name

  owners = [
    for u in data.azuread_user.owners : u.object_id
  ]

  dynamic "required_resource_access" {
    for_each = length(var.graph_application_permissions) > 0 ? [1] : []

    content {
      resource_app_id = data.azuread_service_principal.microsoft_graph.application_id

      dynamic "resource_access" {
        for_each = toset(var.graph_application_permissions)

        content {
          id = lookup(
            {
              for role in data.azuread_service_principal.microsoft_graph.app_roles :
              role.value => role.id
            },
            resource_access.key
          )
          type = "Role"
        }
      }
    }
  }
}

# =================================================
# Service Principal
# =================================================
resource "azuread_service_principal" "app_sp" {
  client_id = azuread_application.app.client_id

  owners = [
    for u in data.azuread_user.owners : u.object_id
  ]
}


resource "azuread_conditional_access_policy" "this" {
  display_name = var.policy_name
  state        = var.policy_state

  conditions {

    users {
      included_users  = var.included_users
      excluded_users  = var.excluded_users
      included_groups = var.included_groups
    }

    applications {
      included_applications = var.cloud_app_ids
    }

    sign_in_risk_levels = var.sign_in_risk_levels
    user_risk_levels    = var.user_risk_levels

    platforms {
      included_platforms = var.device_platforms
    }

    locations {
      included_locations = length(var.include_locations) > 0 ? var.include_locations : ["All"]
      excluded_locations = var.exclude_locations
    }

    client_app_types = [
      "browser",
      "mobileAppsAndDesktopClients"
    ]
  }

  grant_controls {
    operator = "OR"

    built_in_controls = var.block_access ? ["block"] : (
      var.grant_mfa ? ["mfa"] : []
    )
  }
}

