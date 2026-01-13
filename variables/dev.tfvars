# Task 1 Provisioning the entra id roles 
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


#Registering the applications & adding or delegate API permissions to owners list
app_display_name = "terraform-clean-app"

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

#task 3 Conditional Access Policy to block high-risk sign-ins
policy_name  = "CA-Block-High-Risk-Signins-DEV"
policy_state = "enabled"

included_users = ["All"]

excluded_users = [
  "11111111-aaaa-bbbb-cccc-222222222222" # Break-glass
]

cloud_app_ids = ["All"]

sign_in_risk_levels = [
  "high",
  "medium"
]

user_risk_levels = []

device_platforms = [
  "windows",
  "macOS",
  "android",
  "iOS"
]

include_locations = ["All"]
exclude_locations = []

block_access = true
grant_mfa    = false
