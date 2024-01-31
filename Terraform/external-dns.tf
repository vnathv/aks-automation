# resource "helm_release" "external_dns" {
#   name       = "external-dns"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "external-dns"
#   namespace  = "default"

#   set {
#     name  = "provider"
#     value = "azure"
#   }

#   set {
#     name  = "azure.useManagedIdentityExtension"
#     value = "true"
#   }

#   set {
#     name  = "azure.managedIdentityClientID"
#     value = azurerm_user_assigned_identity.dns_identity.client_id
#   }

#   set {
#     name = "subscriptionId"
#     value = local.subscription_id
#   }
#   set {
#     name = "resourceGroup"
#     value = "vijay-aks-new"
#   }


#   depends_on = [azurerm_kubernetes_cluster.this, azurerm_user_assigned_identity.dns_identity]
# }