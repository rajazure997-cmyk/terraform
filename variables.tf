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