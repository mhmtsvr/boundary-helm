# Create Global Scope
resource "boundary_scope" "global" {
  global_scope = true
  description  = "Global Scope"
  scope_id     = "global"
  name         = "global"
}

# Create organization scope within global
resource "boundary_scope" "my_org_organization" {
  name                     = "Organization"
  description              = "Organization"
  scope_id                 = boundary_scope.global.scope_id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "my_org_project" {
  name                     = "Organization Project"
  scope_id                 = boundary_scope.my_org_organization.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

# Create Postgres Host Catalog / Host / Host-set
resource "boundary_host_catalog_static" "postgres_host_catalogs" {
  name     = "Postgres Host Catalog"
  scope_id = boundary_scope.my_org_project.id
}

resource "boundary_host_static" "postgres_hosts" {
  name            = "Postgres Host"
  address         = "database-cluster-rw.database.svc.cluster.local"
  host_catalog_id = boundary_host_catalog_static.postgres_host_catalogs.id
}

resource "boundary_host_set_static" "postgres_host_sets" {
  host_catalog_id = boundary_host_catalog_static.postgres_host_catalogs.id
  type            = "static"
  name            = "Postgres Host Set"
  host_ids = [
    boundary_host_static.postgres_hosts.id
  ]
}

# Create a target for Postgres
resource "boundary_target" "postgres_targets" {
  name         = "Postgres"
  type         = "tcp"
  default_port = "5432"
  scope_id     = boundary_scope.my_org_project.id
  host_source_ids = [
    boundary_host_set_static.postgres_host_sets.id
  ]
}
