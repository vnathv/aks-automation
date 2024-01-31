resource "azurerm_user_assigned_identity" "dns-aks-identity" {
  name                = "dns-aks-identity"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

# resource "azurerm_role_assignment" "this" {
#   scope                = azurerm_resource_group.this.id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_user_assigned_identity.this.principal_id
# }

resource "azurerm_role_assignment" "contributor_main_resource_group" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.dns-aks-identity.principal_id

  depends_on = [ azurerm_user_assigned_identity.dns-aks-identity ]
}

# resource "azurerm_role_assignment" "contributor_node_resource_group" {
#   scope                = data.azurerm_resource_group.node_resource_group.id
#   role_definition_name = "Contributor"
#   principal_id         = azurerm_user_assigned_identity.dns-aks-identity.principal_id

#   depends_on = [ azurerm_user_assigned_identity.dns-aks-identity ]
# }

resource "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "aks-vijay"

  kubernetes_version        = local.aks_version
  automatic_channel_upgrade = "stable"
  private_cluster_enabled   = false
  node_resource_group       = "${local.resource_group_name}-node-resource-group"

  
  sku_tier = "Free"

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.64.10"
    service_cidr   = "10.0.64.0/19"
  }

  default_node_pool {
    name                 = "general"
    vm_size              = "Standard_D2_v2"
    vnet_subnet_id       = azurerm_subnet.subnet1.id
    orchestrator_version = local.aks_version
    type                 = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    node_count           = 1
    min_count            = 1
    max_count            = 10

    node_labels = {
      role = "general"
    }
  }

  # service_principal {
  #   client_id = ""
  #   client_secret = "" 
  # }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.dns-aks-identity.id]
  }

  tags = {
    env = local.env
  }
}

# resource "kubernetes_namespace" "this" {
#   metadata {
#     name = local.namespace
#   }
#   depends_on = [azurerm_kubernetes_cluster.this]
# }
