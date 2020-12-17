resource "google_service_account" "service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
  project      = var.project_id
  description  = var.service_account_description
}

# A custom role to provide access to Cloud SQL and BigQuery aswell as common k8s tasks #
resource "google_project_iam_custom_role" "service_account_custom_role" {
  role_id     = var.role_name
  title       = var.role_name
  description = var.role_description
  permissions = [
    "bigquery.datasets.create",
    "bigquery.datasets.get",
    "bigquery.datasets.getIamPolicy",
    "bigquery.datasets.updateTag",
    "bigquery.models.create",
    "bigquery.models.delete",
    "bigquery.models.export",
    "bigquery.models.getData",
    "bigquery.models.getMetadata",
    "bigquery.models.list",
    "bigquery.models.updateData",
    "bigquery.models.updateMetadata",
    "bigquery.models.updateTag",
    "bigquery.routines.create",
    "bigquery.routines.delete",
    "bigquery.routines.get",
    "bigquery.routines.list",
    "bigquery.routines.update",
    "bigquery.tables.create",
    "bigquery.tables.delete",
    "bigquery.tables.export",
    "bigquery.tables.get",
    "bigquery.tables.getData",
    "bigquery.tables.getIamPolicy",
    "bigquery.tables.list",
    "bigquery.tables.update",
    "bigquery.tables.updateData",
    "bigquery.tables.updateTag",
    "cloudsql.instances.connect",
    "cloudsql.instances.get",
    "container.clusters.get",
    "container.clusters.list",
    "container.clusters.update",
    "container.operations.get",
    "container.operations.list",
    "resourcemanager.projects.get",
    "pubsub.topics.publish",
    "storage.objects.get",
    "storage.objects.getIamPolicy",
    "storage.objects.list"
  ]
}

# Bind the service account to the role #
resource "google_project_iam_binding" "service_account_custom_binding" {
  role = "projects/${var.project_id}/roles/${google_project_iam_custom_role.service_account_custom_role.role_id}"

  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}

# To apply the service account to gke nodes, we need to grant the service account the following role #
resource "google_project_iam_binding" "service_account_default_binding" {
  role = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}