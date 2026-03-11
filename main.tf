resource "azuread_group" "ad_security_groups" {

  for_each = local.ad_security_group_map

  display_name     = each.value.display_name
  description      = try(each.value.description, null)

  security_enabled = true
  mail_enabled     = false
  mail_nickname    = replace(lower(each.value.display_name), " ", "-")

  owners  = try(each.value.owners, [])
  members = try(each.value.members, [])
}