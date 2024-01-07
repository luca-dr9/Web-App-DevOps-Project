resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
    name                = "aks-vnet"
    location            = var.location
    resource_group_name = var.resource_group_name
    address_space = var.vnet_address_space
}

resource "azurerm_subnet" "control-sub" {
    name                 = "control-plane-subnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "worker-sub" {
    name                 = "worker-node-subnet"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "example" {
    name                = "aks-nsg"
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name = "kube-apiserver-rule"
        priority = 1001
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = 6443
        source_address_prefix = "77.101.194.237"
        destination_address_prefix = "*"
    }

    security_rule {
        name = "ssh-rule"
        priority = 1002
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = 22
        source_address_prefix = "77.101.194.237"
        destination_address_prefix = "*"
    }
}