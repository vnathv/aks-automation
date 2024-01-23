resource "azuread_application" "this" {
  display_name = "vijay-aks-ad"
  owners = [ "e752421b-9932-4a18-b2bc-89551c8c0140" ]
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
  owners = azuread_application.this.owners
}

resource "azurerm_role_assignment" "dns_contributor" {
  principal_id   = azuread_service_principal.this.id
  role_definition_name = "DNS Zone Contributor"
  scope          = azurerm_dns_zone.example-dns.id
  depends_on = [ azurerm_dns_zone.example-dns ]
}

resource "azurerm_role_assignment" "reader" {
  principal_id   = azuread_service_principal.this.id
  role_definition_name = "Reader"
  scope          = azurerm_resource_group.this.id

  depends_on = [ azurerm_resource_group.this ]
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.object_id
}