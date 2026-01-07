# Boundary Helm Chart

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/mhmtsvr/boundary-helm/tree/main.svg?style=shield)](https://dl.circleci.com/status-badge/link/gh/mhmtsvr/boundary-helm/tree/main)
[![Chart Version](https://img.shields.io/badge/chart-0.1.0-informational)](https://github.com/mhmtsvr/boundary-helm)
[![Boundary Version](https://img.shields.io/badge/boundary-0.21.0-purple)](https://www.boundaryproject.io/)
[![License](https://img.shields.io/github/license/mhmtsvr/boundary-helm)](https://github.com/mhmtsvr/boundary-helm/blob/main/LICENSE)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/boundary)](https://artifacthub.io/packages/search?repo=boundary)
[![GitHub Contributions](https://img.shields.io/badge/contributions-welcome-orange.svg)](https://github.com/mhmtsvr/boundary-helm/blob/main/CONTRIBUTING.md)

This is a community Helm chart for deploying [HashiCorp Boundary](https://www.boundaryproject.io/)￼ on Kubernetes. Since HashiCorp has not yet released an official chart, this project provides a simple way to get Boundary up and running in your cluster.

The chart is community-maintained, has no commercial intent, and is provided as-is while respecting Boundary’s licensing.

## Prerequisites

By default, this chart requires a Kubernetes secret containing the Postgres URI. Create it as shown below.

```
kubectl create namespace boundary
kubectl create secret generic boundary-database-secret \
  --from-literal=url="postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_ENDPOINT}:${DB_PORT}/${DB_NAME}" \
  -n boundary
```

To use HashiCorp Vault instead of Kubernetes Secrets, see [the Vault integration](#vault-integration).

Follow [the full prerequisites](PREREQUISITES.md) to set up Postgres and Vault (optional).

## Install

1. Install the chart:
    ```bash
    helm upgrade --install boundary oci://ghcr.io/mhmtsvr/boundary -n boundary --create-namespace
    ```

2. Get initial admin credentials
    ```bash
    kubectl logs -n boundary -l app.kubernetes.io/name=boundary-init --tail=-1
    ```

3. Disable init job after successful initialization
    ```bash
    helm upgrade boundary oci://ghcr.io/mhmtsvr/boundary -n boundary \
      --set initialize.enabled=false \
      --reuse-values
    ```

As the OCI Helm chart is signed by [Cosign](https://github.com/sigstore/cosign) as part of the release process you can verify the chart before installing it by running the following command.

```bash
cosign verify ghcr.io/mhmtsvr/boundary:0.1.0 \
  --certificate-identity-regexp='https://circleci\.com/api/v2/projects/.+/pipeline-definitions/.+' \
  --certificate-oidc-issuer-regexp='https://oidc\.circleci\.com/org/.+' \
  --annotations=version=0.1.0
```

## Access

Port-forward the controller to access Boundary locally:
```bash
kubectl port-forward -n boundary svc/boundary-controller 9200:9200
```

Login at http://localhost:9200

## Configuration

Key values:
- `controller.config`: Boundary controller configuration
- `worker.config`: Boundary worker configuration
- `worker.loadbalancer.publicAddr`: Public address for workers (required for external access)
  - Your cloud provider will likely provision a load balancer automatically. Once the chart is deployed, you can get the IP and update the chart. If you are testing on Minikube, the default value should work — Minikube will allocate the IP when you run `minikube tunnel` in a terminal:
    ```
    kubectl get svc boundary-worker-lb -n boundary -o jsonpath='{.status.loadBalancer.ingress[*].ip}'
    ```

- `vault.enabled`: Use Vault for database credentials (default: false)

See [values](boundary-helm/README.md#values) for all options.

See [terraform example](/examples/terraform) for further configuration reference.

## Upgrade

See [UPGRADE.md](UPGRADE.md) for upgrade instructions.

## Vault Integration

If you have Vault set up, use the override config:
```bash
helm upgrade --install boundary oci://ghcr.io/mhmtsvr/boundary -n boundary \
  -f examples/helm/values-config-override.yaml
```

If you need to set up Vault from scratch, see [the prerequisites](PREREQUISITES.md#optional-hashicorp-vault-deployment-guide).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.
