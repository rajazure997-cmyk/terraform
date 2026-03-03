variable "conditional_access_policies" {
  description = "List of Conditional Access Policies to manage."
  type = list(object({
    name                     = string
    include_role_template_ids = optional(list(string), [])
    include_user_object_ids  = optional(list(string), [])
    exclude_user_object_ids  = optional(list(string), [])
    include_applications     = optional(list(string), [])
    include_platforms        = optional(list(string), [])
    client_app_types         = optional(list(string), [])
    grant_controls           = optional(list(string), [])
    state                    = optional(string, "enabled")   # enabled, disabled, enabledForReportingButNotEnforced
  }))
  default = []
}