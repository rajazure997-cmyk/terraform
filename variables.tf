variable "ad_security_groups" {
  description = "List of AD Security Groups to create in Entra ID"
  type = list(object({
    display_name     = string
    description      = optional(string)
    owners           = optional(list(string), [])
    members          = optional(list(string), [])
    security_enabled = optional(bool, true)
  }))
  default = []
}