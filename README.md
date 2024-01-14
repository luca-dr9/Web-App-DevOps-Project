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

**Variables:** 
- "resource_group_name" variable that represents the name of the Azure Resource Group where the networking resources will be deployed in. 
- "location" variable that specifies the Azure region where the networking resources will be deployed to. 
- "vnet_address_space" variable that specifies the address space for the Virtual Network (VNet).

**Main:** 
- "azurerm_resource_group.example" resource for the Azure Resource Group.
- "azurerm_virtual_network.example" resource for the Virtual Network. 
- "azurerm_subnet.control-sub" resource for the Control Plane Subnet. 
- "azurerm_subnet.worker-sub" resource for the Worker Node Subnet. 
- "azurerm_network_security_group.example" resource for the Network Security Group that includes 2 inbound rules: one to allow traffic to the kube-apiserver (named kube-apiserver-rule) and one to allow inbound SSH traffic (named ssh-rule).

**Output:** 
- "vnet_id", "control_plane_subnet_id" and "worker_node_subnet_id" variables store the ID of the Vnet, control plane subnet and worker node subnet, respectively. 
- "networking_resource_group_name" variable that will provide the name of the Azure Resource Group. 
- "aks_nsg_id" variable will store the ID of the Network Security Group (NSG).

### AKS Cluster Module

**Variables:** 
- "aks_cluster_name" variable for the name of the AKS cluster. 
- "cluster_location" variable for the Azure region where the AKS cluster will be deployed to. 
- "dns_prefix" variable for the DNS prefix of cluster. 
- "kubernetes_version" variable that specifies which Kubernetes version the cluster will use. 
- "service_principle_client_id" variable that provides the Client ID for the serivce principle associated with the cluster. 
- "service_principle_secret" variable that supplies the CLient Secret Secret for the service principle. 
- Also includes these output variables from the networking module as input variables: "resource_group_name", "vnet_id", "control_plane_subnet_id" and "worker_node_subnet_id".

**Main:**
 - "azurerm_kubernetes_cluster.aks_cluster" resource for an Azure Kubernetes Service (AKS) cluster with specified configuration, including a default node pool and a serice principle for authentication.

**Output:**
 - "aks_cluster_name" variable to store the name of the provisioned cluster. 
 - "aks_cluster_id" variable for the ID of the cluster. 
 - "aks_kubeconfig" variable that will capture the Kubernetes configuration file fo the cluster.

### AKS Terraform Main Directory

**Variables:** 

"subscription_id", "tenant_id", "client_id" and "client_secret" only environment variables to prevent exposing credentials.

**Main:** 

First added the Azure provider block to enable authentication to Azure using service principal credentials. Integrated the Netowrking Module using input variable. Integrated the Cluster Module using input varaibles and the output variables from the Networking Module.

## Kubernetes Deployment

### Deployment Manifest

- Deployment named "flask-app-deployment", with 2 replicas.

- App and pod template are labled "app: flask-app".

- Container called "flask-app-container" with image from DockerHub "lucadr9/luca-devops-image" and exposes port 5000.

- Rolling Update Stategy to facilitate seamless application updates, during updates, a maximum of one pod deploys while one pod becomes temporarily unavailable, maintaining application availability.

### Service Manifest

- Service named "flask-app-service" with label "app: flask-app".

- Uses TCP protocol on port 80, with tagetPort set to 5000, corresponding to the exposed port.

- Service type is set to ClusterIP

### Deployment Strategy

The Rolling Updates deployment strategy has been chosen to ensure a smooth deployment process with minimal disruption. This strategy allows for gradual updates, minimizing downtime by deploying one pod at a time while keeping the application available.

### Testing and Validation

- Used "kubectl get pods" to ensure that all pods are in the "Running" state

- Used "kubectl get services" to ensure service is created with type ClusterIP

- Checked logs and events with "kubectl logs" and more info with "kubectl describe pods" to make sure there arre no errors/issues.

## CI/CD Pipeline with Azure DevOps

- The source repository is main and the pipeline is triggered when changes are made to the main branch.

- The build pipeline uses docker task to build and push the Docker image to Docker Hub.

- The release pipeline deploys the application to AKS using Kubernetes Manifest task.

### Validation Steps:

- Check build pipeline by going on Docker Hub and checking if it has been push recently.

- Check the release pipeline by using 'kubectl pods' or 'kubectl logs' to make sure they are running and no errors occured.

## AKS Cluster Monitoring

### Metric Explorer Charts

- Average Node CPU Usage: This chart allows you to track the CPU usage of your AKS cluster's nodes. Monitoring CPU usage helps ensure efficient resource allocation and detect potential performance issues.

- Average Pod Count: This chart displays the average number of pods running in your AKS cluster. It's a key metric for evaluating the cluster's capacity and workload distribution.

- Used Disk Percentage: Monitoring disk usage is critical to prevent storage-related issues. This chart helps you track how much disk space is being utilized.

- Bytes Read and Written per Second: Monitoring data I/O is crucial for identifying potential performance bottlenecks. This chart provides insights into data transfer rates.

### Log Analytics

- Average Node CPU Usage Percentage per Minute: This configuration captures data on node-level usage at a granular level, with logs recorded per minute

- Average Node Memory Usage Percentage per Minute: Similar to CPU usage, tracking memory usage at node level allows you to detect memory-related performance concerns and efficiently allocate resources

- Pods Counts with Phase: This log configuration provides information on the count of pods with different phases, such as Pending, Running, or Terminating. It offers insights into pod lifecycle management and helps ensure the cluster's workload is appropriately distributed.

- Find Warning Value in Container Logs: By configuring Log Analytics to search for warning values in container logs, you proactively detect issues or errors within your containers, allowing for prompt troubleshooting and issues resolution

- Monitoring Kubernetes Events: Monitoring Kubernetes events, such as pod scheduling, scaling activities, and errors, is essential for tracking the overall health and stability of the cluster

### Alarms

- Used Disk Percentage: Alarm triggers if AKS cluster exceeds 90%. This alert is vital because it helps you proactively detect and address potential disk issues that could lead to performance degradation and service interruptions. The alert checks every 5 minutes and has a loopback period of 15 minutes. If triggered, should increase disk capacity or optimise usage.

- CPU Usage Percentage: Alarm triggers if AKS cluster exceeds 80%. The alert checks every 1 minute and has a loopback period of 5 minutes. If triggered, check resource using most, then optimise.

- Memory Working Set Percentage: Alarm triggers if AKS cluster exceeds 80%. The alert checks every 1 minute and has a loopback period of 5 minutes. If triggered, optimise memory usage.

- The alerts are configured to send notfications to email.

## Azure Key Vault for Secret Management

- Azure Key Vault Setup: First had to create the Azure Key Vault then assign RBAC Roles in Key Vault. I assigned myself as Key Vault Administator, so I have full access.

- Secrets Stored: I created the secrets: Database-Name, Server-Name, Server-Username and Server-Password. These were all used to make the database connection in the application code without hardcoding the values.

- AKS Integration: Created a user-assigned Managed Identity then assigned it the role, Key Vault Secrets Officer. Therefore it could access the secrets in the Key Vault.

- Application Code Modifications: Set up Azure Key Vault client with Managed Identity, then accessed the secret vaules from the Key Vault, finally assigned those values to the already used variables (instead of hardcoding the secrets values).

## DevOps Pipeline Architecture

![DevOps Pipeline Architecture](https://github.com/luca-dr9/Web-App-DevOps-Project/assets/148899235/e78cfe0a-2929-4f6f-8e55-9ea850c10c9f)

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
