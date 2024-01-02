kubectl label namespace vijay-ingress cert-manager.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager `
  --namespace vijay-ingress `
  --version v1.13.3 `
  --set installCRDs=true
