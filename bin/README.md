## Pre Setup for TF
These scripts initialize the Azure environment for Terraform.
1. `az-provider-setup.sh` script registers required providers such as Microsoft.Storage so Terraform can use Azure resources.
2. `tf-backend-storage.sh` creates a storage account and container to serve as the remote backend for storing the Terraform state.
3. `rbac.sh` creates a service principal used for authentication and running Terraform from GitHub.
4. `ssh-gen.sh` generates an SSH key pair for Ansible, which is later used within the workflow for secure server access and automation.    
A possible **improvement** would be to introduce a unified environment configuration file shared across all scripts, ensuring consistent variable management and simplifying setup for different environments.