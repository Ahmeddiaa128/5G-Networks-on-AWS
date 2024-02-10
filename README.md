# 5G-Networks-on-AWS
Continuous Integration and Continuous Delivery for 5G Networks on AWS
# AWS Infrastructure with Amazon EKS Cluster and Managed Node Group
This Terraform configuration sets up an Amazon Web Services (AWS) infrastructure using modules for creating a Virtual Private Cloud (VPC), an Amazon Elastic Kubernetes Service (EKS) cluster, an EKS managed node group, and an additional AWS security group. The infrastructure is designed to provide a scalable and secure environment for deploying containerized applications using Kubernetes.

Table of Contents
Introduction
Features
Prerequisites
Usage
Configuration
Customization
Contributing

# Introduction
The infrastructure setup includes the following components:

VPC Module: Sets up a VPC with public and private subnets across availability zones, enabling the mapping of public IP addresses on launch.

EKS Module: Creates an Amazon EKS cluster with various addons such as CoreDNS, kube-proxy, vpc-cni, and aws-ebs-csi-driver. It configures security group rules and IAM roles for cluster authentication.

EKS Managed Node Group Module: Sets up a managed node group for the EKS cluster, defining the capacity, instance types, and bootstrap user data.

Additional AWS Security Group: Creates an extra security group with custom ingress rules for added security.

# Features
Infrastructure as Code (IaC) using Terraform.
Scalable and resilient architecture with AWS managed services.
Integration with Amazon EKS for container orchestration.
Modular approach for easy management and customization.
# Prerequisites
Before getting started, ensure you have the following:

AWS account with appropriate permissions to create resources.
Terraform installed on your local machine.
AWS CLI configured with necessary credentials.
# Usage
To use this Terraform configuration:

Clone this repository to your local machine.
Update the terraform.tfvars file with your specific configurations.
Run terraform init to initialize the Terraform workspace.
Run terraform plan to view the execution plan.
Run terraform apply to create the infrastructure.
Configuration
You can customize the configuration by modifying the terraform.tfvars file and adjusting the variables in the modules according to your requirements. Refer to the Terraform documentation for detailed explanations of each module's configuration options.

# Customization
Feel free to customize the Terraform configuration to fit your specific use case. You can add or remove modules, adjust resource settings, or integrate with other AWS services as needed. Contributions and suggestions for improvement are welcome!

# Contributing
Contributions are welcome! If you have any ideas, suggestions, or improvements, please open an issue or create a pull request. For major changes, please discuss them first by opening an issue to ensure they align with the project's goals.