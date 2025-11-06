#!/usr/bin/env bash
set -euo pipefail

NAME="${1:-terraform-sp}"
SUB="${2:-}"

if [[ -n "$SUB" ]]; then
  az account set --subscription "$SUB" 1>/dev/null
fi

SUB_ID="$(az account show --query id -o tsv)"
SCOPE="/subscriptions/$SUB_ID"

# Create SP and assign Contributor at subscription scope (2 years)
az ad sp create-for-rbac \
  --name "$NAME" \
  --role "Contributor" \
  --scopes "$SCOPE" \
  --years 2 \
  -o json > backup/"${NAME//:/_}".json
