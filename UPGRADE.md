# Boundary Upgrade Guide

⚠️ It’s strongly recommended to test each new version before upgrading — even minor version bumps can introduce breaking changes. Boundary does not support downgrades. If a rollback is required, you may need to delete the boundary PostgreSQL database or restore it from a backup before redeploying the desired version from scratch.

Check possible breaking changes in releases and upgrade documentation
  - https://github.com/hashicorp/boundary/releases
  - https://developer.hashicorp.com/boundary/tutorials/self-managed-deployment/upgrade-version

## Upgrade Steps

1. As of the time of writing, boundary controller needs to be scalled down for the upgrade.
    ```bash
    kubectl -n boundary scale sts boundary-controller --replicas=0
    ```
3. Enable init job for database migration
    ```bash
    helm upgrade boundary oci://ghcr.io/mhmtsvr/boundary -n boundary \
      --set initialize.enabled=true \
      --set initialize.image.tag=${NEW_BOUNDARY_VERSION} \
      --set controller.image.tag=${NEW_BOUNDARY_VERSION} \
      --set worker.image.tag=${NEW_BOUNDARY_VERSION} \
      --reuse-values
    ```

3. Disable init job after successful upgrade
    ```bash
    helm upgrade boundary oci://ghcr.io/mhmtsvr/boundary -n boundary \
      --set initialize.enabled=false \
      --reuse-values
    ```
