

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update


helm install ingress-nginx ingress-nginx/ingress-nginx `
    --namespace vijay-ingress `
    --set controller.replicaCount=2 `
    --set "controller.nodeSelector.kubernetes\.io/os=linux" `
    --set "defaultBackend.nodeSelector.kubernetes\.io/os=linux" `
    --set controller.service.externalTrafficPolicy=Local `
    --set controller.service.loadBalancerIP="20.31.89.124"

    helm uninstall ingress-nginx -n vijay-ingress

