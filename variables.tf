# =================================================
# BASIC VARIABLES
# =================================================
variable "rgname" {}
variable "rglocation" {}
variable "new_user_upn" {}
variable "new_group_display_name" {}
variable "app_display_name" {}

# =================================================
# APPLICATION OWNERS (GUIDs ONLY)
# =================================================
variable "app_owners" {
  description = "Object IDs of application owners"
  type        = list(string)
}

# =================================================
# API PERMISSIONS (CORRECT SCHEMA)
# =================================================
variable "api_permissions" {
  description = "API permissions for the application"
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
}
