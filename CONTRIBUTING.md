# Contributing to Boundary Helm Chart (Unofficial)

Thank you for your interest in contributing to this community Helm chart for HashiCorp Boundary! This document provides guidelines and instructions for contributing.

## How to Report Issues

### Before Submitting an Issue

- Check the [existing issues](https://github.com/mhmtsvr/boundary-helm/issues) to avoid duplicates
- Review the [README](README.md) and [PREREQUISITES](PREREQUISITES.md) to ensure proper setup
- Test with the latest version of the chart

### Creating an Issue

Please submit helm chart related issues under this repo. For Boundary product issues, please visit [Hashicorp Boundary](https://github.com/hashicorp/boundary/issues)

When reporting a bug in the helm chart, please include:

- Helm chart version
- Kubernetes version (`kubectl version`)
- Boundary version
- PostgreSQL version
- Steps to reproduce the issue
- Expected vs actual behavior
- Relevant logs from pods (`kubectl logs -n boundary <pod-name>`)
- Your values.yaml configuration (sanitized of sensitive data)

## Pull Request Process

### 1. Fork and Clone

```bash
git clone https://github.com/<your-username>/boundary-helm.git
cd boundary-helm
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
```

Use descriptive branch names:
- `feature/add-hpa-support`
- `fix/controller-env-vars`
- `docs/update-readme`

### 3. Make Your Changes

- Follow existing code style and conventions
- Update documentation if needed
- Keep changes focused and atomic

### 4. Test Your Changes

See the [Testing Requirements](#testing-requirements) section below.

### 5. Commit Your Changes

Write clear, concise commit messages:

```bash
git commit -m "Add Gateway API support"
```

Good commit message format:
- Use present tense ("Add feature" not "Added feature")
- Keep first line under 72 characters
- Add detailed description in body if needed

### 6. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Create a pull request with:
- Clear title describing the change
- Description of what changed and why
- Reference to any related issues (`Fixes #123`)
- Screenshots or logs if applicable

### 7. Code Review

- Respond to feedback promptly
- Make requested changes in new commits
- Keep the discussion focused and professional

### 8. Merge

Once approved, a maintainer will merge your PR. The branch will be deleted automatically.

## Development Setup

### Prerequisites

See [PREREQUISITES.md](PREREQUISITES.md) for details.

### Setting Up for Development

For detailed instructions on deploying and configuring Boundary, refer to the [README.md](README.md).

### Local Development Workflow

1. **Make changes to chart templates or values**

2. **Lint and validate your changes**
    ```bash
    helm lint boundary-helm/
    helm template boundary boundary-helm/ --debug
    ```

3. **Test**
    ```bash
    helm install boundary-test boundary-helm/ -n boundary --create-namespace
    ```

4. **Verify and clean up**
    ```bash
    kubectl get pods -n boundary
    helm uninstall boundary-test -n boundary
    kubectl delete namespace boundary-test
    ```

### Working with Values

When adding new values:
- Add to `boundary-helm/values.yaml` with sensible defaults
- Document the value with inline comments
- Consider backward compatibility
- Test with and without the value set

## Testing Requirements

All contributions must pass the following tests (lint and template rendering automated in CI/CD):

1. Helm Lint
    ```bash
    helm lint boundary-helm/
    ```

    Should return no errors. Fix any warnings when possible.

  2. Template Rendering
      ```bash
      helm template boundary boundary-helm/ --debug
      ```

      Should render without errors.

  3. Dry Run Installation
      ```bash
      helm install boundary-test boundary-helm/ \
        -n boundary \
        --create-namespace \
        --dry-run \
        --debug
      ```

      Should complete without errors.

  4. Actual Installation Test
      Test in a real Kubernetes cluster:

      ```bash
      # Install
      helm install boundary-test boundary-helm/ -n boundary --create-namespace

      # Verify pods are running
      kubectl get pods -n boundary

      # Check logs for errors
      kubectl logs -n boundary -l app.kubernetes.io/name=boundary-controller --tail=50

      # Test upgrade
      helm upgrade boundary-test boundary-helm/ -n boundary

      # Clean up
      helm uninstall boundary-test -n boundary
      kubectl delete namespace boundary-test
      ```

  5. Documentation

  - Update README.md if adding user-facing features
  - Update values.yaml comments

## Questions?

If you have questions about contributing:
- Open a discussion in the GitHub repository
- Reference existing issues and PRs for examples
- Check the [Helm documentation](https://helm.sh/docs/) for Helm-specific questions

Thank you for contributing to make this Boundary Helm chart better!
