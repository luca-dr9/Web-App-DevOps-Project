# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Roadmap

### Adding Delivery Date

 Made a branch that adds a delivery date column. Feature was reverted, but could be used in future by merging feature branch.

### Dockerfile

- **Creating Dockerfile:**
Uses python:3.8-slim as parent image. Sets working directory to /app then copies the application files in the container. Installs system dependecies and ODBC driver. Installs ppip and setuptools. installs python packages specified in requirements.txt. Exposes port 5000. Defines startup command, CMD ["python", "app.py"]

- **Docker Hub:**
Pushed to Docker Hub with tag: [lucadr9/luca-devops-image](https://hub.docker.com/r/lucadr9/luca-devops-image)

## AKS Terraform

Deploying the containerised application onto a Kubernetes cluster to ensure application scalability. To achieve this, I've implemeted infrastructure as code using Terraform.

First, I created the Terraform project directory, aks-terraform. Then inside created two module directories: networking-module and aks-cluster-module. One for provisioning the necessary Azure Networking Services for an AKS cluster and one for provisioning the Kubernetes cluster itself.

### Networking Module

- **Variables:** "resource_group_name" variable that represents the name of the Azure Resource Group where the networking resources will be deployed in. "location" variable that specifies the Azure region where the networking resources will be deployed to. "vnet_address_space" variable that specifies the address space for the Virtual Network (VNet).

- **Main:** "azurerm_resource_group.example" resource for the Azure Resource Group."azurerm_virtual_network.example" resource for the Virtual Network. "azurerm_subnet.control-sub" resource for the Control Plane Subnet. "azurerm_subnet.worker-sub" resource for the Worker Node Subnet. "azurerm_network_security_group.example" resource for the Network Security Group that includes 2 inbound rules: one to allow traffic to the kube-apiserver (named kube-apiserver-rule) and one to allow inbound SSH traffic (named ssh-rule).

- **Output:** "vnet_id", "control_plane_subnet_id" and "worker_node_subnet_id" variables store the ID of the Vnet, control plane subnet and worker node subnet, respectively. "networking_resource_group_name" variable that will provide the name of the Azure Resource Group. "aks_nsg_id" variable will store the ID of the Network Security Group (NSG).

### AKS Cluster Module

- **Variables:** "aks_cluster_name" variable for the name of the AKS cluster. "cluster_location" variable for the Azure region where the AKS cluster will be deployed to. "dns_prefix" variable for the DNS prefix of cluster. "kubernetes_version" variable that specifies which Kubernetes version the cluster will use. "service_principle_client_id" variable that provides the Client ID for the serivce principle associated with the cluster. "service_principle_secret" variable that supplies the CLient Secret Secret for the service principle. Also includes these output variables from the networking module as input variables: "resource_group_name", "vnet_id", "control_plane_subnet_id" and "worker_node_subnet_id".

- **Main:** "azurerm_kubernetes_cluster.aks_cluster" resource for an Azure Kubernetes Service (AKS) cluster with specified configuration, including a default node pool and a serice principle for authentication.

- **Output:** "aks_cluster_name" variable to store the name of the provisioned cluster. "aks_cluster_id" variable for the ID of the cluster. "aks_kubeconfig" variable that will capture the Kubernetes configuration file fo the cluster.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Contributors 

- [Maya Iuga](https://github.com/maya-a-iuga)
- [Luca Di Rienzo](https://github.com/luca-dr9) - luca.direnzo9@gmail.com
- [Project Link](https://github.com/luca-dr9/Web-App-DevOps-Project)

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.
