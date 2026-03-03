resource "azuread_conditional_access_policy" "policies" {
  for_each = local.conditional_access_map

  display_name = each.value.name
  state        = try(each.value.state, "enabled")

  conditions {
    users {
      # Directory roles to include
      included_roles = try(each.value.include_role_template_ids, [])

      # Specific users to include (if any)
      included_users = try(each.value.include_user_object_ids, [])

      # Specific users to exclude (break-glass)
      excluded_users = try(each.value.exclude_user_object_ids, [])
    }

    applications {
      # All apps if "All" is specified, else list of IDs
      included_applications = try(each.value.include_applications, [])
    }

    platforms {
      included_platforms = try(each.value.include_platforms, [])
    }

    # Client app types like browser and mobile/desktop
    client_app_types = try(each.value.client_app_types, [])
  }

  grant_controls {
    operator = "OR"
    built_in_controls = try(each.value.grant_controls, [])
  }
}