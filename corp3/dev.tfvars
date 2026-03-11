ad_security_groups = [

  {
    display_name = "CORP3-SPO-ACCESS-GROUP"
    description  = "Security group for SharePoint access"

    owners = [
      "56ca4c4f-34b6-42d5-8def-22461ecd3df0"
    ]

    members = [
      "56ca4c4f-34b6-42d5-8def-22461ecd3df0",
      "0f2197a0-504d-4ecc-8cef-649cbe68e8ae"
    ]
  },

  {
    display_name = "CORP3-AKS-ADMIN-GROUP"
    description  = "AKS admin security group"

    owners = [
      "56ca4c4f-34b6-42d5-8def-22461ecd3df0"
    ]

    members = [
      "56ca4c4f-34b6-42d5-8def-22461ecd3df0"
    ]
  }

]