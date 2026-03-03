# =================================================
# Providers
# =================================================
# provider "azurerm" {
#   features {}
#   # tenant_id       = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
#   # subscription_id = "4edf8b82-34bd-4aa2-a2f3-9fdb7b1df5ad"
#   #tenant_id = "40666927-43dd-4cdd-9ec3-74161a2f838e" #root level
#   #subscription_id = "af675ebe-9f6b-4113-938e-819e5a56407c" #root level
#   tenant_id = "8e6c9735-8163-48a9-a19b-80843e8e9c3c"
#   #subscription_id = "8e6c9735-8163-48a9-a19b-80843e8e9c3c"
# }

provider "azuread" {
  # tenant_id = "4555b9e5-a4e8-477a-b522-19e35b8b4473"
  tenant_id = "40666927-43dd-4cdd-9ec3-74161a2f838e"
}


