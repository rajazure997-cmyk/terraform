locals {

  ad_security_group_map = {
    for grp in var.ad_security_groups :
    grp.display_name => grp
  }

}