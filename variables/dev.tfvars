# =================================================
# RESOURCE GROUP
# =================================================
rgname      = "new-rg-group3"
rglocation = "westus2"

# =================================================
# USER DETAILS (Entra ID User Creation)
# =================================================
new_user_upn           = "external.user1@rajazure997gmail.onmicrosoft.com"
new_user_display_name  = "External User One"
new_user_mail_nickname = "externaluser1"
initial_password       = "TempP@ssw0rd@123!" 

# =================================================
# GROUP DETAILS
# =================================================
new_group_display_name = "new-users-group"

# =================================================
# APPLICATION DETAILS
# =================================================
app_display_name = "terraform-demo-app"

# Application owners (UPNs, NOT object IDs)
app_owners = [
  "rajazure997_gmail.com#EXT#@rajazure997gmail.onmicrosoft.com"
]

# =================================================
# MICROSOFT GRAPH APPLICATION PERMISSIONS
# =================================================
graph_application_permissions = [
  "User.Read.All",
  "Directory.Read.All"
]

# =================================================
# ENTRA ID DIRECTORY ROLES (Provision / De-Provision)
# =================================================
entra_roles = [
  "Global Reader",
  # "Application Administrator"
  "User Administrator"
]
