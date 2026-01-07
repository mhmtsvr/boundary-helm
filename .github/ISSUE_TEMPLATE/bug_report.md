---
name: Bug report
about: Create a report to help us improve the Boundary Helm chart
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Description

A clear and concise description of what the bug is.

## Environment

**Chart Version:**
<!-- e.g., x.y.z -->

**Kubernetes Version:**
<!-- Output of: kubectl version -->

**Boundary Version:**
<!-- e.g., x.y.z -->

**PostgreSQL Version:**
<!-- e.g., 18.1 -->

**Helm Version:**
<!-- Output of: helm version -->

## Steps to Reproduce

1. Install the chart with '...'
2. Configure values '...'
3. Execute command '...'
4. See error

## Expected Behavior

A clear and concise description of what you expected to happen.

## Actual Behavior

A clear and concise description of what actually happened.

## Relevant Logs

```
Paste relevant logs here from:
kubectl logs -n boundary <pod-name>
```

## Configuration

Please provide your `values.yaml` configuration (sanitized of sensitive data):

```yaml
# Your values.yaml content here
```

## Additional Context

Add any other context about the problem here (screenshots, error messages, etc.).

## Checklist

- [ ] I have checked the [existing issues](https://github.com/mhmtsvr/boundary-helm/issues) to avoid duplicates
- [ ] I have reviewed the [README](https://github.com/mhmtsvr/boundary-helm/blob/main/README.md) and [PREREQUISITES](https://github.com/mhmtsvr/boundary-helm/blob/main/PREREQUISITES.md)
- [ ] I have tested with the latest version of the chart
- [ ] I have sanitized any sensitive information from logs and configurations
