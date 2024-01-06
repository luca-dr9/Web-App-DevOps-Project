output "vnet_id" {
    description = "The ID of the VNet"
    value = azurerm_virtual_network.example.id
}

output "control_plane_subnet_id" {
    description = "The ID of the control plane subnet within the VNet"
    value = azurerm_subnet.control-sub.id
}

output "worker_node_subnet_id" {
    description = "The ID of the worker node subnet within the VNet"
    value = azurerm_subnet.worker-sub.id
}

output "networking_resource_group_name" {
    description = "The name of the Azure Resource Group"
    value = azurerm_resource_group.example.name
}

output "aks_nsg_id" {
    description = "The ID of the Network Security Group (NSG)"
    value = azurerm_network_security_group.example.id
}