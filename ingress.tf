
resource "helm_release" "nginx_ingress" {
  name       = "${azurerm_resource_group.rg.name}-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart     = "ingress-nginx"
  namespace = kubernetes_namespace.vijay-aks-namespace.metadata[0].name
  version   = "4.0.2"  # Use the version you want

  set {
    name = "controller.replicaCount"
    value = 2
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.vijay-az-pulic-ip.ip_address
  }

  set {
    name  = "rbac.create"
    value = "false"
  }

   set {
    name  = "controller.ingressClass"
    value = "nginx"
  }
  set {
    name  = "controller.service.enableHttp"
    value = "true"
  }
  depends_on = [ kubernetes_namespace.vijay-aks-namespace ]

  #values = data.external.ingress_values.result
}



output "NamespaceName" {
  value = kubernetes_namespace.vijay-aks-namespace.metadata[0].name
}


# # resource "helm_release" "nginx_ingress" {
# #   name       = "nginx-ingress"
# #   repository = "https://kubernetes.github.io/ingress-nginx"
# #   chart      = "ingress-nginx"
# #   version    = "3.36.0"
# #   values = [
# #     <<-EOT
# #     controller:
# #       service:
# #         loadBalancerIP: "${azurerm_public_ip.vijay-az-pulic-ip.ip_address}"
# #     EOT
# #   ]
# # }

# # data "external" "ingress_values" {
# #     program = ["powershell.exe", "-c", "Get-Content ${path.module}/ingress-values-template.yaml -Raw"]   
# #     query = {
# #     REPLICA_COUNT     = 2
# #     SUBNET_ID         = azurerm_subnet.vijay-aks-subnet.id  # Replace with your actual subnet ID
# #     LOAD_BALANCER_IP  = azurerm_public_ip.vijay-az-pulic-ip.ip_address
# #   } 
# # }