# #!/usr/bin/env bash

# =========================================================
# AZURE INFRASTRUCTURE BOOTSTRAP SCRIPT
# Sets subscription and registers required providers for TF.
# =========================================================

# 1. SET SUBSCRIPTION
# CHANGE THIS: Replace the placeholder with your actual Subscription ID or Name.
SUBSCRIPTION_ID="dev-lab-112"

echo "Setting active Azure subscription..."
az account set --subscription "$SUBSCRIPTION_ID"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to set subscription. Check ID/Name and authentication."
    exit 1
fi
echo "Subscription set successfully."

# 2. REGISTER REQUIRED PROVIDERS
echo "Starting registration for required Resource Providers..."

# Register the necessary providers
az provider register --namespace Microsoft.Compute
az provider register --namespace Microsoft.Storage
az provider register --namespace Microsoft.Network
az provider register --namespace Microsoft.Resources

# 3. VERIFY STATUS
echo ""
echo "--- CURRENT PROVIDER STATUS ---"
# List the status of the providers we care about
az provider list \
    --query "[?contains(['Microsoft.Compute', 'Microsoft.Storage', 'Microsoft.Network', 'Microsoft.Resources'], namespace)].{Provider:namespace, Status:registrationState}" \
    --output table

echo ""
echo "Setup complete. Status should show 'Registered'."
