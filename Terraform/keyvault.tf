# resource "azurerm_key_vault" "this" {
#   name                = "aks-key-vault-vijay"
#   resource_group_name = azurerm_resource_group.this.name
#   location            = azurerm_resource_group.this.location
#   enabled_for_disk_encryption = true
#   tenant_id           = local.tenant_id
#   sku_name            = "standard"

#   access_policy {
#     tenant_id = local.tenant_id
#     object_id = "e752421b-9932-4a18-b2bc-89551c8c0140"
#     secret_permissions = [
#       "Get",
#       "List",
#       "Set",
#       "Delete",
#     ]
#   }
# }

# resource "azurerm_key_vault_secret" "this" {
#   name         = azuread_service_principal.this.client_id
#   value        = azuread_service_principal_password.this.value
#   key_vault_id = azurerm_key_vault.this.id
# }
