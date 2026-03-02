variable "conditional_access_policies" {
  description = "List of Conditional Access Policies"
  type = list(object({
    name                     = string
    included_user_object_ids = list(string)
    excluded_user_object_ids = list(string)
    included_app_ids         = list(string)
    included_platforms       = list(string)
    client_app_types         = list(string)
    grant_controls           = list(string)
  }))
  default = []
}