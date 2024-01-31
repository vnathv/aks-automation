resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = local.namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}