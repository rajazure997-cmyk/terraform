# variable "entra_role_assignments" {
#   description = "Simple list of Entra ID role assignments"

#   type = list(object({
#     principal_object_id = string
#     role_name           = string
#   }))

#   default = []
# }
variable "entra_role_assignments" {
  description = "Map of principals and their roles"

  type = map(object({
    principal_object_id = string
    roles               = list(string)
  }))

  default = {}
}

