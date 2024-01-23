resource "azurerm_user_assigned_identity" "dns_identity" {
  name                = "dns-identity-${local.env}"
  resource_group_name = azurerm_resource_group.this.name
  location = azurerm_resource_group.this.location
}

resource "azurerm_role_assignment" "contributor_assignment_dns" {
  scope                = azurerm_dns_zone.example-dns.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.dns_identity.principal_id
}