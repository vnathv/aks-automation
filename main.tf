# terraform {
#   required_providers {
#     azurerm = {
#       source = "hashicorp/azurerm"
#       version = "3.83.0"
#     }
#     helm = {
#       source = "hashicorp/helm"
#       version = "2.12.1"
#     }
#     kubernetes = {
#       source = "hashicorp/kubernetes"
#       version = "2.24.0"
#     }
#   }
# }

# provider "azurerm" {
#     features {
      
#     }
#     subscription_id = var.subscription_id
# }

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"  # Path to your kubeconfig file
#   }
# }
# provider "kubernetes" {
#   config_path    = "~/.kube/config"
#   # Configuration options
# }

# locals {
#   resource_group_name = azurerm_resource_group.rg.name
#   location = azurerm_resource_group.rg.location
# }

# #Resource group creation
# resource "azurerm_resource_group" "rg" {
#     name = var.resource_group_name
#     location = var.resource_group_location
# }

# #AKS version
# data "azurerm_kubernetes_service_versions" "aks_version" {
#   include_preview = false
#   location = azurerm_resource_group.rg.location
#   version_prefix = "1.26"
# }

# #Create Azure AD group for AKS admins
# resource "azuread_group" "vij-aks-admin" {
#   display_name = "${azurerm_resource_group.rg.name}-cluster-admins"
#   security_enabled = true
# }

# #Create virtual network
# resource "azurerm_virtual_network" "vijay-aks-vnet" {
#   name = "${azurerm_resource_group.rg.name}-vnet"
#   address_space = [ "10.0.0.0/16" ]
#   location = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

# #Creating subnet
# resource "azurerm_subnet" "vijay-aks-subnet" {
#   address_prefixes = [ "10.0.240.0/24" ]
#   name = "${azurerm_virtual_network.vijay-aks-vnet.name}-subnet"
#   resource_group_name = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vijay-aks-vnet.name
#   depends_on = [ azurerm_virtual_network.vijay-aks-vnet ]
# }

# #Create log analytics workspace
# resource "azurerm_log_analytics_workspace" "vijay-aks-loganalytics" {
#   name = "${azurerm_resource_group.rg.name}-loganalytics"
#   location = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   retention_in_days = 30
# }

# #create user assigned managed identity
# resource "azurerm_user_assigned_identity" "vijay-userassigned-mi" {
#   name = "${azurerm_resource_group.rg.name}-managed-identity"
#   resource_group_name = azurerm_resource_group.rg.name
#   location = azurerm_resource_group.rg.location
# }

# #create azure container registry
# resource "azurerm_container_registry" "vijay-aks-acr" {
#   name = "vijayacr65765"
#   resource_group_name = local.resource_group_name
#   location = local.location
#   sku = "Standard"
#   identity {
#     type = "UserAssigned"
#     identity_ids = [azurerm_user_assigned_identity.vijay-userassigned-mi.id]
#   }
# }

# #assigning acrpull role to managed identity
# resource "azurerm_role_assignment" "vijay-az-roleassignment" {
#   scope = azurerm_container_registry.vijay-aks-acr.id
#   principal_id = azurerm_user_assigned_identity.vijay-userassigned-mi.principal_id
#   role_definition_name = "AcrPull"  
# }

# resource "azurerm_public_ip" "vijay-az-pulic-ip" {
#   allocation_method = "Static"
#   location = azurerm_resource_group.rg.location
#   name = "${azurerm_resource_group.rg.name}-public-ip"
#   resource_group_name = azurerm_resource_group.rg.name
#   sku = "Standard"
# }

# resource "kubernetes_namespace" "vijay-aks-namespace" {
#   metadata {
#     name = "${azurerm_resource_group.rg.name}-aks-namespace"    
#   }
# }

# # resource "helm_release" "nginx_ingress" {
# #   name       = "nginx-ingress"
# #   repository = "https://kubernetes.github.io/ingress-nginx"
# #   chart      = "ingress-nginx"
# #   version    = "3.36.0"
# #   namespace = kubernetes_namespace.vijay-aks-namespace.metadata[0].name

# #   values = [
# #     <<-EOT
# #     controller:
# #       service:
# #         loadBalancerIP: "${azurerm_public_ip.vijay-az-pulic-ip.ip_address}"
# #     EOT
# #   ]
# # }


# # helm install ingress-nginx ingress-nginx/ingress-nginx --namespace vijay-aks-aks-namespace --set controller.replicaCount=2 --set controller.nodeSelector."kubernetes\.io/os"=linux --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux --set controller.service.externalTrafficPolicy=Local --set controller.service.loadBalancerIP="20.160.178.97"
