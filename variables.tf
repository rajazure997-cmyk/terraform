# --- Azure Resource Group Variables ---

variable "rgname" {
    type        = string
    description = "The name for the Azure Resource Group."
    # default     = "newone-rg2"
}

variable "rglocation" {
    type        = string
    description = "The Azure region/location for the Resource Group (e.g., eastus, westus2)."
    # default     = "eastus" 
    
    validation {
      # Simple check: Location should not be empty
      condition     = length(var.rglocation) > 0
      error_message = "The Resource Group location cannot be empty."
    }
}

 variable "new_group_display_name" {
  type        = string
  description = "The display name for the new Group."
#   default     = "remote_access_users"
}

variable "new_user_upn" {
    type        = string
  description = "The User Principal Name (UPN) for the new user (e.g., user@verifieddomain.onmicrosoft.com)."
  # IMPORTANT: The default must use your tenant's actual verified domain.
#   default     = "rajazure997_gmail.com#EXT#@rajazure997gmail.onmicrosoft.com"
  
}
variable "role_to_assign" {
  description = "The name of the Azure built-in role to assign."
  type        = string
#   default     = "Global Reader"
}