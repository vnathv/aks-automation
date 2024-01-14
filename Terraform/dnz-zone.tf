resource "azurerm_dns_zone" "example-dns" {
  name                = "techops.today"
  resource_group_name = azurerm_resource_group.this.name
}