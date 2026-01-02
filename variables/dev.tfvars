<<<<<<< HEAD
# =================================================
# RESOURCE GROUP
# =================================================
=======
# Task 1 Provisioning the entra id roles 
>>>>>>> b2b8e87939a062c274bfc64c416c8fd8b0c3be0f
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

<<<<<<< HEAD
# =================================================
# APPLICATION DETAILS
# =================================================
app_display_name = "terraform-demo-app"
=======

#Registering the applications & adding or delegate API permissions to owners list
app_display_name = "terraform-clean-app"
>>>>>>> b2b8e87939a062c274bfc64c416c8fd8b0c3be0f

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
