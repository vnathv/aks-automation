resource "azurerm_public_ip" "this" {
  name                = "vijay-public-ip"
  resource_group_name = "${local.resource_group_name}-node-resource-group"
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku = "Standard"

  tags = {
    environment = "Development"
  }

  depends_on = [ azurerm_kubernetes_cluster.this ]
}

output "public_ip" {
  value = azurerm_public_ip.this.ip_address
}