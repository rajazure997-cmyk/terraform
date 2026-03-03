conditional_access_policies = [
  {
    name                      = "MFA: Privileged Access Roles"

    # Directory role template IDs to include for policy
    include_role_template_ids = [
      "62e90394-69f5-4237-9190-012177145e10", # Global Administrator
      "194ae4cb-b126-40b2-bd5b-6091b380977d", # Privileged Role Administrator
      "729827e3-9c14-49f7-bb1b-9608f156bbb8", # Security Administrator
      "158c047a-c907-4556-b7ef-446551a6b5f7", # Conditional Access Administrator
      "fe930be7-5e62-47db-91af-98c3a49a38b1"  # User Administrator
      # add more role template IDs as needed
    ]

    # Excluded users (break-glass, emergency accounts)
    exclude_user_object_ids = [
      "BREAK_GLASS_USER_OBJECT_ID_1",
      "BREAK_GLASS_USER_OBJECT_ID_2"
      # Add the full object IDs of the 8 users you showed in screenshot
    ]

    # Could also include explicit user object IDs if needed
    include_user_object_ids = []

    # Apply to all cloud apps
    include_applications = ["All"]

    # Device platforms shown in screenshot — adjust if needed
    include_platforms = [
      "windows",
      "macOS",
      "android",
      "iOS"
    ]

    # Client apps: Browser + Mobile/Desktop
    client_app_types = [
      "browser",
      "mobileAppsAndDesktopClients"
    ]

    # Grant control to enforce MFA
    grant_controls = ["mfa"]

    # Policy enabled immediately
    state = "enabled"
  }
]