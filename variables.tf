# --- Azure Resource Group Variables ---

variable "rgname" {
    type = string
    description = "The name for the Azure Resource Group."
    default = "newone-rg"
}

variable "rglocation" {
    type = string
    description = "The Azure region/location for the Resource Group."
    default = "eastus" 
}

# --- Entra ID User Variables ---

variable "new_user_upn" {
  type        = string
  description = "The User Principal Name (UPN) for the new user (e.g., user@verifieddomain.onmicrosoft.com)."
  # IMPORTANT: The default must use your tenant's actual verified domain.
  default     = "new.user.terraform@rajazure997gmail.onmicrosoft.com"
}

variable "new_user_display_name" {
  type        = string
  description = "The display name for the new user."
  default     = "Terraform Provisioned User"
}

variable "initial_password" {
  type        = string
  description = "The initial password for the new user."
  # The 'sensitive' tag ensures this value is hidden in logs/state.
  # This value MUST be set in Terraform Cloud variables or via -var.
  sensitive   = true 
}

variable "directory_role_name" {
  type        = string
  description = "The display name of the Microsoft Entra ID Directory Role to assign (e.g., 'Global Reader' or 'User Administrator')."
  default     = "Global Reader"
}