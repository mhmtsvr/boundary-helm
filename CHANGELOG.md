# Boundary-Helm CHANGELOG

All notable changes to the Boundary Helm chart will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-01-07

### 🎉 Initial Release

This is the first release of the community Boundary Helm chart, providing a simple way to deploy HashiCorp Boundary on Kubernetes.

### Added

#### Core Components
- **Controller StatefulSet**: Highly available Boundary controller setup with configurable replicas (default: 3), using StatefulSet for stable network identities enabling direct pod-to-pod cluster communication via headless service
- **Worker StatefulSet**: Scalable worker setup with configurable replicas (default: 3), using StatefulSet for stable pod names and predictable addressing for worker registration with controllers
- **Initialization Job**: One-time setup job for database initialization and admin user creation

#### Database Integration
- PostgreSQL integration with configurable connection parameters
- Support for external PostgreSQL databases
- Database credentials management via Kubernetes secrets
- Optional Vault integration for secure credential storage

#### Security & Authentication
- Vault integration for managing database credentials
- Support for both KMS and DEV key management systems
- Secure secret handling for authentication tokens and passwords

#### Networking
- Controller service with ClusterIP type (port 9200 for API, 9201 for cluster)
- Worker service with LoadBalancer support for external access
- Configurable public addresses for worker ingress
- Health check endpoints for both controllers and workers

#### High Availability
- Multi-replica support for controllers and workers
- Pod disruption budgets for production resilience
- Liveness and readiness probes for automatic recovery

#### Configuration
- Comprehensive values.yaml with sensible defaults
- Support for custom configuration overrides
- Resource limits and requests configuration
- Node selector, tolerations, and affinity rules

#### Documentation
- Detailed README with quick start guide
- Prerequisites documentation for PostgreSQL and Vault setup
- Upgrade guide for future releases
- Release process documentation
- Contributing guidelines

### Technical Details
- **Chart Version**: 0.1.0
- **App Version**: Boundary 0.21.0
- **Kubernetes Version**: >= 1.32.0
- **License**: Apache 2.0

### Notes
- This is a community-maintained chart with no official HashiCorp support
- Vault integration is optional and can be enabled via configuration
- Initial admin credentials can be retrieved from the init job logs
- After successful initialization, the init job should be disabled

[0.1.0]: https://github.com/mhmtsvr/boundary-helm/releases/tag/v0.1.0
