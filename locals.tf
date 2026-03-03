locals {
  conditional_access_map = {
    for p in var.conditional_access_policies :
    p.name => p
  }
}