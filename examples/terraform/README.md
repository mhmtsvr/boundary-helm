# Boundary Terraform

Terraform configuration for setting up Boundary scopes, hosts, and targets for Postgres access.

## Setup

```bash
terraform init
terraform apply
```

## Connect to Postgres via Boundary

```bash
boundary authenticate
boundary connect -target-name=Postgres --target-scope-name "Organization Project" -listen-port 5432
```

Then connect your database client to `localhost:5432`.

## Variables

Set these if different from defaults:
- `boundary_addr` (default: `http://localhost:9200/`)
- `boundary_username` (default: `admin`)
- `boundary_password`
