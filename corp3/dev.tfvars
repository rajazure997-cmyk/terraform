conditional_access_policies = [
  {
    name = "Block SPO/OD for Turkey Users"

    included_user_object_ids = [
      "56ca4c4f-34b6-42d5-8def-22461ecd3df0"
    ]

    excluded_user_object_ids = []

    # Office 365 SharePoint Online App ID
    included_app_ids = [
      "00000003-0000-0ff1-ce00-000000000000"
    ]

    included_platforms = [
      "windows",
      "macOS",
      "android",
      "iOS"
    ]

    client_app_types = [
      "browser",
      "mobileAppsAndDesktopClients"
    ]

    grant_controls = [
      "block"
    ]
  }
]