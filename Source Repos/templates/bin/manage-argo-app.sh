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
    "CI_PROJECT_URL"
    "CI_COMMIT_BRANCH"
    "KUBERNETES_SERVER"
    "CONFIG_DIR"
    "APPLICATION_NAME"
    "TARGET_NAMESPACE"
    "GITLAB_TOKEN"
)

# Check required environment variables
for var in "${required_env_vars[@]}"; do
    if [ -z "${!var}" ]; then
        log_error "$var environment variable is not set"
        exit 1
    fi
done

log_info Creating application $APPLICATION_NAME

# Check if application already exists
if argocd app list --server "$ARGOCD_SERVER" --auth-token "$ARGOCD_AUTH_TOKEN" --insecure --grpc-web -o name | grep -q "^${APPLICATION_NAME}$"; then
    log_info "Application ${APPLICATION_NAME} already exists in ArgoCD. Pipeline will not create application."
    exit 0
fi

# Prepare values file parameter if provided
if [ -n "$VALUES_FILE" ]; then
    VALUES_PARAM="--values $VALUES_FILE"
else
    VALUES_PARAM=""
fi



log_info "Adding repository for the ${CI_PROJECT_NAME} project"
argocd repo add --grpc-web --project "$ARGOCD_PROJECT" "${CI_PROJECT_URL}.git" --username oauth2  --password "$GITLAB_TOKEN"

# Create the application
log_info "Creating application ${APPLICATION_NAME}"
argocd app create "$APPLICATION_NAME" \
    --repo "${CI_PROJECT_URL}.git" \
    --revision "$CI_COMMIT_BRANCH" \
    --path "$CONFIG_DIR" \
    --dest-server "$KUBERNETES_SERVER" \
    --dest-namespace "$TARGET_NAMESPACE" \
    --project "$ARGOCD_PROJECT" \
    --server "$ARGOCD_SERVER" \
    --auth-token "$ARGOCD_AUTH_TOKEN" \
    --sync-policy "$SYNC_POLICY" \
    --insecure \
    --grpc-web \
    $VALUES_PARAM

log_info "Application ${APPLICATION_NAME} successfully created in ArgoCD"