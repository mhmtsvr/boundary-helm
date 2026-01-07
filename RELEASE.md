# RELEASE PROCESS

This document explains how releases work for the Boundary Helm chart.

## How Releases Work

Releases follow semantic versioning and are automated through CircleCI:

- **Version Tags**: Releases are triggered when maintainers push a version tag (e.g., `v0.2.0`)
- **Chart Version**: The chart version is updated in [Chart.yaml](boundary-helm/Chart.yaml).
- **Automation**: CircleCI handles linting, packaging, and publishing
- **Documentation**: [helm-docs](https://github.com/norwoodj/helm-docs) generates the README.md from values.yaml automatically. The CI pipeline validates that documentation is up-to-date but does not commit changes. Maintainers must run helm-docs locally and commit the generated README.md:
  ```bash
  helm-docs --chart-search-root=boundary-helm
  git diff boundary-helm/README.md
  ```
- **Distribution**: Charts are published to:
  - GitHub Releases (`.tgz` packages)
  - GitHub Container Registry (OCI artifacts at `ghcr.io/mhmtsvr/boundary`)

_**Releases are managed by maintainers.**_
