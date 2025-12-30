# Task 1 Provisioning the entra id roles 
rgname      = "new-rg-group3"
rglocation = "westus2"

new_user_upn            = "rajazure997_gmail.com#EXT#@rajazure997gmail.onmicrosoft.com"
new_group_display_name = "new-users-group"


#Registering the applications & adding or delegate API permissions to owners list
app_display_name = "terraform-clean-app"

# MUST be OBJECT IDs, not email
app_owners = [
  "ad0666a4-558a-410d-9050-4435e9ef8534"
]

# Microsoft Graph → User.Read.All (Application permission)
api_permissions = [
  {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access = [
      {
        id   = "df021288-bdef-4463-88db-98f22de89214"
        type = "Role"
      }
    ]
  }
]
