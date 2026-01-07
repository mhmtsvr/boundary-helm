# boundary

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.21.0](https://img.shields.io/badge/AppVersion-0.21.0-informational?style=flat-square)

Hashicorp Boundary Community Chart (Unofficial)

This is a community Helm chart for deploying [HashiCorp Boundary](https://www.boundaryproject.io/)￼ on Kubernetes. Since HashiCorp has not yet released an official chart, this project provides a simple way to get Boundary up and running in your cluster.

The chart is community-maintained, has no commercial intent, and is provided as-is while respecting Boundary’s licensing.

See the [installation guide](https://github.com/mhmtsvr/boundary-helm?tab=readme-ov-file#prerequisites) in the repository README for setup instructions.

## Requirements

Kubernetes: `>= 1.32.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| controller.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"boundary-controller"}},"topologyKey":"kubernetes.io/hostname"},"weight":100}]}}` | Affinity rules (default: anti-affinity for HA) |
| controller.annotations | object | `{}` | Extra annotations to attach to the controller pods |
| controller.config | string | See values.yaml | Boundary controller configuration |
| controller.extraLabels | object | `{}` | Extra labels to attach to the controller pods |
| controller.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| controller.image.repository | string | `"hashicorp/boundary"` | Image repository |
| controller.image.tag | string | `"0.21.0"` | Image tag |
| controller.ingress.annotations | object | `{}` | Ingress annotations |
| controller.ingress.enabled | bool | `false` | Enable ingress |
| controller.ingress.extraPaths | list | `[]` | Extra paths |
| controller.ingress.hosts | list | `[{"host":"chart-example.local","paths":[]}]` | Ingress hosts |
| controller.ingress.ingressClassName | string | `""` | Ingress class name |
| controller.ingress.labels | object | `{}` | Ingress labels |
| controller.ingress.pathType | string | `"Prefix"` | Path type for ingress |
| controller.ingress.tls | list | `[]` | TLS configuration |
| controller.nodeSelector | object | `{}` | Node selector for controller pods |
| controller.podDisruptionBudget.enabled | bool | `true` | Enable PodDisruptionBudget for controller pods |
| controller.podDisruptionBudget.minAvailable | int | `2` | Minimum available pods during disruptions |
| controller.preStop | list | `[]` | Custom preStop commands |
| controller.preStopSleepSeconds | int | `5` | Sleep seconds during preStop hook |
| controller.priorityClassName | string | `""` | Priority class name |
| controller.replicas | int | `3` | Number of controller replicas |
| controller.resources.limits.cpu | string | `"300m"` |  |
| controller.resources.limits.memory | string | `"384Mi"` |  |
| controller.resources.requests.cpu | string | `"100m"` |  |
| controller.resources.requests.memory | string | `"384Mi"` |  |
| controller.securityContext.container.allowPrivilegeEscalation | bool | `false` |  |
| controller.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| controller.securityContext.container.readOnlyRootFilesystem | bool | `true` |  |
| controller.securityContext.pod.fsGroup | int | `1000` |  |
| controller.securityContext.pod.runAsGroup | int | `1000` |  |
| controller.securityContext.pod.runAsNonRoot | bool | `true` |  |
| controller.securityContext.pod.runAsUser | int | `100` |  |
| controller.service.annotations | object | `{}` | Service annotations |
| controller.serviceAccount.annotations | object | `{}` | Service account annotations |
| controller.strategy | object | `{}` | Deployment update strategy |
| controller.terminationGracePeriodSeconds | int | `10` | Termination grace period in seconds |
| controller.tolerations | list | `[]` | Tolerations for controller pods |
| controller.topologySpreadConstraints | list | `[]` | Topology spread constraints |
| controller.volumeMounts | list | `[]` | Extra volume mounts to add to the controller container |
| controller.volumes | list | `[]` | Extra volumes to add to the controller pods |
| database.additionalUrlParameters | string | `""` | Additional URL parameters for database connection |
| database.databaseName | string | `"boundary"` | Database name |
| database.secretKey | string | `"url"` | Secret key for database URL |
| database.secretName | string | `"boundary-database-secret"` | Secret name containing database URL |
| global.extraSecretEnvironmentVars | list | `[]` | Extra environment variables from secrets (injected into all pods) |
| global.imagePullSecrets | list | `[]` | Image pull secrets for registry authentication |
| global.namePrefix | string | `"boundary"` | Prefix for resource names |
| global.namespace | string | `"boundary"` | Kubernetes namespace |
| initialize.annotations | object | `{}` | Extra annotations |
| initialize.enabled | bool | `true` | Enable initialization job (run once to bootstrap cluster) |
| initialize.extraLabels | object | `{}` | Extra labels |
| initialize.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| initialize.image.repository | string | `"hashicorp/boundary"` | Image repository |
| initialize.image.tag | string | `"0.21.0"` | Image tag |
| initialize.nodeSelector | object | `{}` | Node selector for init job |
| initialize.priorityClassName | string | `""` | Priority class name |
| initialize.resources.limits.cpu | string | `"300m"` |  |
| initialize.resources.limits.memory | string | `"256Mi"` |  |
| initialize.resources.requests.cpu | string | `"100m"` |  |
| initialize.resources.requests.memory | string | `"256Mi"` |  |
| initialize.securityContext.container.allowPrivilegeEscalation | bool | `false` |  |
| initialize.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| initialize.securityContext.container.readOnlyRootFilesystem | bool | `true` |  |
| initialize.securityContext.pod.fsGroup | int | `1000` |  |
| initialize.securityContext.pod.runAsGroup | int | `1000` |  |
| initialize.securityContext.pod.runAsNonRoot | bool | `true` |  |
| initialize.securityContext.pod.runAsUser | int | `100` |  |
| initialize.serviceAccount.annotations | object | `{}` | Service account annotations |
| initialize.tolerations | list | `[]` | Tolerations for init job |
| initialize.volumeMounts | list | `[]` | Extra volume mounts |
| initialize.volumes | list | `[]` | Extra volumes |
| vault.databaseSecretPath | string | `"secret/database/postgres"` | Vault path to database secret (without /data/) |
| vault.enabled | bool | `false` | Enable Vault for database credentials |
| vault.roleName | string | `"boundary"` | Vault role name |
| vault.secretEngine | string | `"kv2"` | Secret engine type (only kv2 supported) |
| worker.affinity | object | `{"podAntiAffinity":{"preferredDuringSchedulingIgnoredDuringExecution":[{"podAffinityTerm":{"labelSelector":{"matchLabels":{"app.kubernetes.io/name":"boundary-worker"}},"topologyKey":"kubernetes.io/hostname"},"weight":100}]}}` | Affinity rules (default: anti-affinity for HA) |
| worker.annotations | object | `{}` | Extra annotations |
| worker.config | string | See values.yaml | Boundary worker configuration |
| worker.extraLabels | object | `{}` | Extra labels |
| worker.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| worker.image.repository | string | `"hashicorp/boundary"` | Image repository |
| worker.image.tag | string | `"0.21.0"` | Image tag |
| worker.loadbalancer.annotations | object | `{}` | LoadBalancer annotations |
| worker.loadbalancer.enabled | bool | `true` | Enable LoadBalancer service |
| worker.loadbalancer.publicAddr | string | `"localhost"` | Public address for workers (required for external access) |
| worker.nodeSelector | object | `{}` | Node selector for worker pods |
| worker.podDisruptionBudget.enabled | bool | `true` | Enable PodDisruptionBudget for worker pods |
| worker.podDisruptionBudget.minAvailable | int | `2` | Minimum available pods during disruptions |
| worker.preStop | list | `[]` | Custom preStop commands |
| worker.preStopSleepSeconds | int | `5` | Sleep seconds during preStop hook |
| worker.priorityClassName | string | `""` | Priority class name |
| worker.replicas | int | `3` | Number of worker replicas |
| worker.resources.limits.cpu | string | `"200m"` |  |
| worker.resources.limits.memory | string | `"256Mi"` |  |
| worker.resources.requests.cpu | string | `"100m"` |  |
| worker.resources.requests.memory | string | `"256Mi"` |  |
| worker.securityContext.container.allowPrivilegeEscalation | bool | `false` |  |
| worker.securityContext.container.capabilities.drop[0] | string | `"ALL"` |  |
| worker.securityContext.container.readOnlyRootFilesystem | bool | `true` |  |
| worker.securityContext.pod.fsGroup | int | `1000` |  |
| worker.securityContext.pod.runAsGroup | int | `1000` |  |
| worker.securityContext.pod.runAsNonRoot | bool | `true` |  |
| worker.securityContext.pod.runAsUser | int | `100` |  |
| worker.service.annotations | object | `{}` | Service annotations |
| worker.serviceAccount.annotations | object | `{}` | Service account annotations |
| worker.strategy | object | `{}` | Deployment update strategy |
| worker.terminationGracePeriodSeconds | int | `10` | Termination grace period in seconds |
| worker.tolerations | list | `[]` | Tolerations for worker pods |
| worker.topologySpreadConstraints | list | `[]` | Topology spread constraints |
| worker.volumeMounts | list | `[]` | Extra volume mounts |
| worker.volumes | list | `[]` | Extra volumes |
