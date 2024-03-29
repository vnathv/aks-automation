data "azurerm_kubernetes_cluster" "this" {
  name                = local.aks_name
  resource_group_name = azurerm_resource_group.this.name 
  depends_on = [azurerm_kubernetes_cluster.this]
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.this.kube_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.this.kube_config.0.cluster_ca_certificate)
    config_path            = "~/.kube/config"
  }
}

# output "host" {
#   value = data.azurerm_kubernetes_cluster.this.kube_config.0.host
# }


resource "helm_release" "nginx" {
  name = "nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "vijay-ingress"
  create_namespace = true
  version          = "4.8.0"
  values = [
    file("${path.module}/values/ingress.yaml"),
    <<-EOT
    controller:
      service:
        loadBalancerIP: "${azurerm_public_ip.this.ip_address}"
    EOT
  ]

  depends_on = [ azurerm_public_ip.this]
}