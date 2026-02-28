1. Provisioning and Deprovisioning Entra ID roles
⦁	Objective of the Terraform Setup
⦁	The goal of this Terraform configuration is to:
⦁	Create and manage users in Microsoft Entra ID
⦁	Provision and de-provision Entra ID directory roles
⦁	Ensure Terraform is the single source of truth
⦁	Avoid:
⦁	Hard-coded IDs
⦁	Manual role assignment in Azure Portal

versions.tf   → Terraform & provider versions
providers.tf  → Azure & AzureAD authentication
variables.tf  → Input variables
dev.tfvars    → Environment-specific values
data.tf       → Read-only lookups
locals.tf     → Computed helper values
main.tf       → Resource creation & deletion


2. Task Statement

“Registering the applications & adding Application / Delegated API permissions along with Owner’s list”

This task is about creating and managing an application identity in Entra ID so that:
An application is registered in Entra ID (Azure AD)
That application has:
------Clearly defined owners
------Explicit API permissions
The application can:
------Authenticate securely
------Call Microsoft APIs or other APIs
All of this is:
Automated
Auditable
