variable "resource_group_name" {
    description = "The name of the Azure resource group where the networking resources will be deployed in"
    type        = string
    default     = "luca-devops-rg"
}

variable "location" {
    description = "The Azure region where the Storage Account will be deployed."
    type        = string
}

variable "vnet_address_space" {
    description = "The address space for the Virtual Network (VNet)"
    type        = list(string)
}