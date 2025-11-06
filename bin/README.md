## Pre Setup for TF
This script sets the active Azure subscription and registers the required resource providers.
It’s needed because Terraform can’t create resources (especially the storage account for the backend) if the Azure providers aren’t registered yet.