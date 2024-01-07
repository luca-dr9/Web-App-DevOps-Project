variable "aks_cluster_name" {
    description = "The name of the AKS cluster"
    type        = string
}

variable "cluster_location" {
    description = "The Azure region where the AKS cluster will be deployed to"
    type        = string
}

variable "dns_prefix" {
    description = "The DNS prefix of cluster"
    type        = string
}

variable "kubernetes_version" {
    description = "The Kubernetes version the cluster will use"
    type        = string
}

variable "service_principle_client_id" {
    description = "The Client ID for the service principal associated with the cluster"
    type        = string
}

variable "service_principle_secret" {
    description = "The Client Secret for the service principal"
    type        = string
}

# Input variables from the networking module
variable "resource_group_name" {
    description = "The name of the Azure Resource Group"
    type        = string
}

variable "vnet_id" {
    description = "The ID of the VNet"
    type        = string
}

variable "control_panel_subnet_id" {
    description = "The ID of the control plane subnet within the VNet"
    type        = string
}

variable "worker_node_subnet_id" {
    description = "The ID of the worker node subnet within the VNet"
    type        = string
}

variable "aks_nsg_id" {
    description = "The ID of the Network Security Group (NSG)"
    type        = string
}