#!/bin/bash

# Exit on error
set -e


# Ensure the init script exists before sourcing
SCRIPT_DIR="$(dirname "$0")"

if [ -f "$SCRIPT_DIR/argo-init.sh" ]; then
    source "$SCRIPT_DIR/argo-init.sh"
else
    echo "[ERROR] argo-init.sh not found!"
    exit 1
fi

# Define required environment variables
required_env_vars=(
    "ARGOCD_SERVER"
    "ARGOCD_AUTH_TOKEN"
    "APPLICATION_NAME"
)

# Check required environment variables
for var in "${required_env_vars[@]}"; do
    if [ -z "${!var}" ]; then
        log_error "$var environment variable is not set"
        exit 1
    fi
done

log_info "Syncing application: $APPLICATION_NAME"

# Sync the application
argocd app sync "$APPLICATION_NAME" \
    --server "$ARGOCD_SERVER" \
    --auth-token "$ARGOCD_AUTH_TOKEN" \
    --insecure \
    --grpc-web

log_info "Application ${APPLICATION_NAME} successfully synced in ArgoCD"
