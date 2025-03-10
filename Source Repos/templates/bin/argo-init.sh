#!/bin/bash

# Exit on error
set -e

# Logging functions
log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

# Set the default for ENV_FILE before loading
ENV_FILE=${ENV_FILE:-"manage-argo-app.env"}

# Source environment file if it exists
if [ -n "$ENV_FILE" ] && [ -f "$ENV_FILE" ]; then
    log_info "Sourcing environment file: $ENV_FILE"
    source "$ENV_FILE"
fi


# Set default values for optional parameters
CONFIG_DIR=${CONFIG_DIR:-"rosa"}
KUBERNETES_SERVER=${KUBERNETES_SERVER:-"https://kubernetes.default.svc"}
ARGOCD_PROJECT=${ARGOCD_PROJECT:-"default"}
SYNC_POLICY=${SYNC_POLICY:-"none"}


log_info "Optional Parameter Values"
log_info "APPLICATION_NAME $APPLICATION_NAME"
log_info "TARGET_NAMESPACE = $TARGET_NAMESPACE"
log_info "CONFIG_DIR $CONFIG_DIR"
log_info "SYNC_POLICY $SYNC_POLICY"


log_info "Initialization complete." 
