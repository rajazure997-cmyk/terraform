# =================================================
# BASIC VARIABLES
# =================================================
# variable "rgname" {
#   description = "Azure Resource Group name"
#   type        = string
# }

variable "rglocation" {
  description = "Azure Resource Group location"
  type        = string
}

# =================================================
# USER CREATION VARIABLES (Entra ID)
# =================================================
variable "new_user_upn" {
  description = "User Principal Name (UPN) for the new Entra ID user"
  type        = string
}

variable "new_user_display_name" {
  description = "Display name for the new Entra ID user"
  type        = string
}

variable "new_user_mail_nickname" {
  description = "Mail nickname for the new Entra ID user"
  type        = string
}

variable "initial_password" {
  description = "Initial password for the Entra ID user"
  type        = string
  sensitive   = true
}

# =================================================
# GROUP VARIABLES
# =================================================
variable "new_group_display_name" {
  description = "Display name of the Azure AD group"
  type        = string
}

# =================================================
# APPLICATION VARIABLES
# =================================================
variable "app_display_name" {
  description = "Display name of the Azure AD application"
  type        = string
}

# =================================================
# APPLICATION OWNERS
# =================================================
variable "app_owners" {
  description = "User Principal Names (UPNs) of application owners"
  type        = list(string)
}

# =================================================
# MICROSOFT GRAPH API PERMISSIONS
# =================================================
variable "graph_application_permissions" {
  description = "Microsoft Graph application permissions (App Roles)"
  type        = list(string)
  default     = []
}

# =================================================
# ENTRA ID DIRECTORY ROLES
# =================================================
variable "entra_roles" {
  description = "Entra ID directory roles to assign to the user (by display name)"
  type        = list(string)
  default     = []
}


variable "policy_name" {
  type = string
}

variable "policy_state" {
  type    = string
  default = "enabled"
}

variable "included_users" {
  type = list(string)
}

variable "excluded_users" {
  type    = list(string)
  default = []
}

variable "included_groups" {
  type    = list(string)
  default = []
}

variable "cloud_app_ids" {
  type = list(string)
}

variable "sign_in_risk_levels" {
  type    = list(string)
  default = []
}

variable "user_risk_levels" {
  type    = list(string)
  default = []
}

variable "device_platforms" {
  type    = list(string)
  default = []
}

variable "include_locations" {
  type    = list(string)
  default = []
}

variable "exclude_locations" {
  type    = list(string)
  default = []
}

variable "grant_mfa" {
  type    = bool
  default = true
}

variable "block_access" {
  type    = bool
  default = false
}
