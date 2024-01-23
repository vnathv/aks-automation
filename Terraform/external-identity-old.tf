# provider "helm" {
#   kubernetes {
#     host                   = module.aks.kube_config.0.host
#     client_certificate     = base64decode(module.aks.kube_config.0.client_certificate)
#     client_key             = base64decode(module.aks.kube_config.0.client_key)
#     cluster_ca_certificate = base64decode(module.aks.kube_config.0.cluster_ca_certificate)
#   }
# }
      
##########
# data sources
##########################
data "azurerm_client_config" "current" {} 
   
##########
# locals
##########################
locals {
  external_dns_vars = {
    resource_group  = "vijay-aks-new",
    tenant_id       = "",
    subscription_id = "",
    log_level       = "debug",
    domain          = "techops.today"
  }

  external_dns_values = templatefile(
    "${path.module}/templates/external_dns_values.yaml.tmpl",
    local.external_dns_vars
  )
}
      
##########
# external_dns - helm chart that adds external-dns functionality
##########################
resource "helm_release" "external_dns" {
  name             = "aks-external-dns"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  namespace        = "vijay-ingress"
  create_namespace = true
  version          = "5.4.5"
  values           = [local.external_dns_values]
}