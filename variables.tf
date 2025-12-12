variable "rgname"{
    type = string
    description = "used for managing the resource group"
    default = "newone"
}

variable "rglocation" {
    type = string
    description = "used for selecting location"
    default = "eastus" 
}


variable "new_user_upn" {
  type        = string
  description = "The User Principal Name (email) for the new user."
  default     = "mansoorshaik7853@yourcompanyname.onmicrosoft.com"
}

variable "new_user_display_name" {
  type        = string
  description = "The display name for the new user."
  default     = "Terraform Provisioned User"
}

variable "initial_password" {
  type        = string
  description = "The initial password for the new user."
  sensitive   = true # Ensures the password is not shown in logs
}

variable "directory_role_name" {
  type        = string
  description = "The display name of the Microsoft Entra ID Directory Role to assign."
  default     = "Global Reader"
}