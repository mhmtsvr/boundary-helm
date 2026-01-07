# PREREQUISITES

- [Kubernetes](https://kubernetes.io/docs/setup/) cluster (local or remote)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/intro/install/) 3.x or later
- [Postgres](https://www.postgresql.org/)
- [Optional] [Vault](https://www.hashicorp.com/en/blog/products/vault)

This document includes steps to set up PostgreSQL and Vault in your test environment. For production use, refer to their official documentation for best practices.

### Postgres Deployment Guide
Follow these steps to set up a PostgreSQL cluster using [CloudNative PG](https://github.com/cloudnative-pg/charts):
  * Deploy Operator chart
      ```bash
      helm repo add cnpg https://cloudnative-pg.github.io/charts
      helm upgrade --install cnpg \
      -n cnpg-system \
      --create-namespace \
      cnpg/cloudnative-pg
      ```
  * Install the database
      ```bash
      helm upgrade --install database \
      -n database \
      --create-namespace \
      cnpg/cluster
      ```
  * Create a database for boundary
      ```bash
      kubectl -n database exec -it database-cluster-1 -- psql -c "CREATE DATABASE boundary OWNER=app;"
      ```
  * Create a Kubernetes secret to store database credentials. Skip this step if `vault.enabled=true`
    ```bash
    export DB_USERNAME=$(kubectl get secret database-cluster-app -n database -o jsonpath="{.data.username}" | base64 --decode)
    export DB_PASSWORD=$(kubectl get secret database-cluster-app -n database -o jsonpath="{.data.password}" | base64 --decode)
    export DB_ENDPOINT=database-cluster-rw.database.svc.cluster.local
    export DB_PORT=5432
    export DB_NAME=boundary

    kubectl create namespace boundary
    kubectl create secret generic boundary-database-secret \
      --from-literal=url="postgresql://${DB_USERNAME}:${DB_PASSWORD}@${DB_ENDPOINT}:${DB_PORT}/${DB_NAME}" \
      -n boundary
    ```
### [OPTIONAL] [Hashicorp Vault Deployment Guide](https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-raft-deployment-guide#setup-helm-repo)

  > Vault is only required if you set `vault.enabled` to `true`.

  * Install [Vault CLI](https://developer.hashicorp.com/vault/install)
  * Deploy Vault
    ```bash
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm install vault hashicorp/vault -n vault --create-namespace \
        --set server.serviceAccount.createSecret=true \
        --set injector.agentImage.tag=1.21.1 \
        --set server.image.tag=1.21.1
    ```
  * Initialize Vault
    ```bash
    kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator init
    ```
  * Unseal Vault
    ```bash
    kubectl -n vault exec --stdin=true --tty=true vault-0 -- vault operator unseal
    ```
    Generally, you should repeat this x3 to unseal the Vault. You will see `Sealed=false` and vault-0 pod in ready state.
  * Port-forward Vault locally
    ```bash
    kubectl -n vault port-forward svc/vault 8200:8200 &

    export VAULT_ADDR=http://127.0.0.1:8200
    export VAULT_TOKEN=<root-token-from-init>
    ```
  * Enable Kubernetes auth
    ```bash
    vault auth enable kubernetes
    ```
  * Configure Kubernetes authentication
    ```bash
    vault write auth/kubernetes/config \
      token_reviewer_jwt="$(kubectl get secret -n vault vault-token -o jsonpath='{.data.token}' | base64 --decode)" \
      kubernetes_host="https://kubernetes.default.svc:443" \
      kubernetes_ca_cert="$(kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}' | base64 --decode)"
    ```

  * Configure Boundary authentication
    ```bash
    vault policy write boundary vault/boundary-policy.hcl
    vault write auth/kubernetes/role/boundary bound_service_account_names="*" \
        bound_service_account_namespaces="*" policies=boundary ttl=24h
    ```

  * Add the Postgres credentials to Vault
    * Enable KV v2 secrets engine
      ```bash
      vault secrets enable -path=secret kv-v2
      ```
    * Add the Postgres credentials to Vault
      ```bash
      vault kv put secret/database/postgres \
          username=$(kubectl get secret database-cluster-app -n database -o jsonpath="{.data.username}" | base64 --decode) \
          password=$(kubectl get secret database-cluster-app -n database -o jsonpath="{.data.password}" | base64 --decode) \
          address=database-cluster-rw.database.svc.cluster.local \
          port=5432
      ```

    * Verify the secret you created.
      ```bash
      vault kv get secret/database/postgres
      ```
