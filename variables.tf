# --- Azure Resource Group Variables ---

variable "rgname" {
    type        = string
    description = "The name for the Azure Resource Group."
    default     = "newone-rg2"
}

variable "rglocation" {
    type        = string
    description = "The Azure region/location for the Resource Group (e.g., eastus, westus2)."
    default     = "eastus" 
    
    validation {
      # Simple check: Location should not be empty
      condition     = length(var.rglocation) > 0
      error_message = "The Resource Group location cannot be empty."
    }
}

 variable "new_group_display_name" {
  type        = string
  description = "The display name for the new Group."
  default     = "remote_access_users"
}

variable "new_user_upn" {
    type        = string
  description = "The User Principal Name (UPN) for the new user (e.g., user@verifieddomain.onmicrosoft.com)."
  # IMPORTANT: The default must use your tenant's actual verified domain.
  default     = "rajazure997_gmail.com#EXT#@rajazure997gmail.onmicrosoft.com"
  
}

# --- Entra ID User Variables ---

# variable "new_user_upn" {
#   type        = string
#   description = "The User Principal Name (UPN) for the new user (e.g., user@verifieddomain.onmicrosoft.com)."
#   # IMPORTANT: The default must use your tenant's actual verified domain.
#   default     = "new.user.terraform@rajazure997gmail.onmicrosoft.com"
# }

# variable "new_user_display_name" {
#   type        = string
#   description = "The display name for the new user."
#   default     = "Terraform Provisioned User"
# }

# variable "initial_password" {
#   type        = string
#   description = "The initial password for the new user."
#   # The 'sensitive' tag ensures this value is hidden in logs/state.
#   sensitive   = true 
  
#   validation {
#     # Simple check: Password cannot be too short (Azure password policy is stricter)
#     condition     = length(var.initial_password) >= 8
#     error_message = "The initial password must be at least 8 characters long."
#   }
# }

# variable "directory_role_name" {
#   type        = string
#   description = "The display name of the Microsoft Entra ID Directory Role to assign (e.g., 'Global Reader' or 'User Administrator')."
#   default     = "Global Reader"
  
#   validation {
#       # This validation ensures the user provides a role name that exists in the locals map in main.tf
#       condition     = contains(["Global Reader", "User Administrator", "Global Administrator"], var.directory_role_name)
#       error_message = "The provided directory_role_name is not supported by the local map. Choose from: Global Reader, User Administrator, Global Administrator."
#     }
# }