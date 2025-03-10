# Pipeline Template Project Documentation

## Templates

### `kaniko.gitlab-ci.yml`

This template builds a Docker image and pushes it into the current GitLab project's registry.

#### **Stage:**
- `docker`

#### **Variables:**
- ***None***

#### **Jobs:**
- `docker`

---

### `argocd-deploy.gitlab-ci.yml`

This template creates an ArgoCD project in the defined ArgoCD installation based on the provided variables.

#### **Stage:**
- `deploy`

#### **Variables:**
- `APPLICATION_NAME`: The application name on ArgoCD
- `CONFIG_DIR`: The directory containing the Kubernetes YAML files.
- `TARGET_NAMESPACE`: The namespace to deploy the application to.
- `SYNC_POLICY`: Defines sync behavior.
  - `none` **(default)**
  - `auto`: Sets sync to auto 
- `ARGOCD_AUTH_TOKEN`: Authentication token for the ArgoCD server.
  - **Recommendation:** Private and Masked.
- `ARGOCD_PROJECT`: The name of the project to associate the ArgoCD application with.
- `ARGOCD_SERVER`: The URL of the ArgoCD server.
- `KUBERNETES_SERVER`: The URL of the Kubernetes/ROSA cluster where the application will be created.
  - Default: `https://kubernetes.default.svc`
- `GITLAB_TOKEN`: Access token for the GitLab project.
  - **Recommendation:** Private and Masked.
  - **Scopes:** `api`, `read_repository`
  - **Role:** `Maintainer` (Possibly `Developer`)
- `ENV_FILE`: Optional file to load at startup.
  - `manage-argo-app.env` **(default)**
  - Should include the path in the GitLab project if not located in the project root.

#### **Jobs:**

##### **`argo-create`**
- **Stage:** `deploy`
- **When:** Manual
- **Script:** `./manage-argo-app.sh`

##### **`argo-sync`**
- **Stage:** `deploy`
- **When:** Manual
- **Depends on:** `argo-create`
- **Script:** `./sync-argo-app.sh`

##### **`argo-delete`**
- **Stage:** `deploy`
- **When:** Manual
- **Depends on:** `argo-create`

