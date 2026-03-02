locals {
  conditional_access_map = {
    for policy in var.conditional_access_policies :
    policy.name => policy
  }
}