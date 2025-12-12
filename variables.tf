variable "rgname"{
    type = string
    description = "used for managing the resource group"
}

variable "rglocation" {
    type = string
    description = "used for selecting location"
    default = "eastus" 
}