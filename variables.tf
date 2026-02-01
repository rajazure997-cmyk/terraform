variable "assignments_file" {
  description = "Path to assignments JSON file"
  type        = string
}

variable "enable_pim" {
  type    = bool
  default = false
}

variable "client_secret" {
  description = "Azure AD application client secret"
  type        = string
  sensitive   = true
}
