locals {
  env                 = "dev"
  region              = "West Europe"
  resource_group_name = "vijay-aks"
  aks_name            = "vijay-test"
  aks_version         = "1.28.3"
  subscription_id     = ""
  tenant_id           = ""
  namespace           = "vijay-ingress"
}

output "namespace" {
  value = local.namespace
}