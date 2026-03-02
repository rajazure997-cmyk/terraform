resource "azuread_conditional_access_policy" "policies" {

  for_each = local.conditional_access_map

  display_name = each.value.name
  state        = "enabled"

  conditions {

    users {
      included_users = each.value.included_user_object_ids
      excluded_users = each.value.excluded_user_object_ids
    }

    applications {
      included_applications = each.value.included_app_ids
    }

    platforms {
      included_platforms = each.value.included_platforms
    }

    client_app_types = each.value.client_app_types
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = each.value.grant_controls
  }
}