#!/usr/bin/env bash


# Customize these values
# Azure Subscription Name
# Environment suffix for container name will be used in backend config of Terraform
# Example "dev", "stage", "prod"
ENV="dev"
SUBSCRIPTION_NAME="dev-lab-112"
# Resource Group Name
RESOURCE_GROUP_NAME="tfstate-rg"
# Azure Region/Location germanywestcentral
LOCATION="germanywestcentral"
# This is just for naming clarity
# Globally unique Storage Account Name
# Azure Storage Account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only.
# Azure Storage Account names must be globally unique, because they form part of the endpoint URL.
STORAGE_ACCOUNT_NAME="tfstatestacc${ENV}1123"
# Container Name for Terraform state
CONTAINER_NAME="${ENV}-tfstate"

echo "--- SETTING UP TERRAFORM BACKEND RESOURCES ---"

# === 2. SET AZURE SUBSCRIPTION ===
echo "Setting Azure subscription to: ${SUBSCRIPTION_NAME}..."
az account set --subscription "$SUBSCRIPTION_NAME"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to set the subscription. Please check the name and login status."
    exit 1
fi
echo "Subscription successfully set."

# === 3. CREATE RESOURCE GROUP (Check & Create) ===
echo "Checking for existence of Resource Group: ${RESOURCE_GROUP_NAME}..."

# Check if Resource Group exists. Redirects stdout/stderr to null
if az group show --name "$RESOURCE_GROUP_NAME" &>/dev/null; then
  echo "Resource Group already exists. Skipping creation."
else
  echo "Creating Resource Group ${RESOURCE_GROUP_NAME} in ${LOCATION}..."
  az group create \
    --name "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --output none
  echo "Resource Group created successfully."
fi

# === 4. CREATE STORAGE ACCOUNT (Check & Create with HNS) ===
echo "Checking for existence of Storage Account: ${STORAGE_ACCOUNT_NAME}..."

# Check if Storage Account exists
if az storage account show --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP_NAME" &>/dev/null; then
  echo "Storage Account already exists. Skipping creation."
else
  echo "Creating Storage Account (with Hierarchical Namespace enabled)..."
  az storage account create \
    --name "$STORAGE_ACCOUNT_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --sku Standard_LRS \
    --kind StorageV2 \
    --hns true \
    --allow-blob-public-access false \
    --output none
  echo "Storage Account created successfully."
fi

# === 5. CREATE BLOB CONTAINER ===
echo "Ensuring container ${CONTAINER_NAME} exists..."

# Attempt to create the container. If it already exists, Azure CLI returns an error.
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --auth-mode login \
  --public-access off 2>/dev/null || true

# NOTE: The success message will print if the container was created OR if it already existed.
echo "Container ${CONTAINER_NAME} is ready (or already existed)."

echo "--------------------------------------------------"
echo "SUCCESS: Terraform backend resources are configured!"
echo "--------------------------------------------------"
echo "Details for your Terraform backend block:"
echo "  resource_group_name    =   $RESOURCE_GROUP_NAME"
echo "  storage_account_name   =   $STORAGE_ACCOUNT_NAME"
echo "  container_name         =   $CONTAINER_NAME"
echo "  key                    =   ${ENV}.tfstate"
echo "--------------------------------------------------"