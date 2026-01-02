# =================================================
# Providers
# =================================================
provider "azurerm" {
  features {}
  tenant_id       = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
  subscription_id = "4edf8b82-34bd-4aa2-a2f3-9fdb7b1df5ad"
}

provider "azuread" {
  tenant_id = "8aaa2c57-c0d2-4cbe-b925-38c6341de9bf"
}
