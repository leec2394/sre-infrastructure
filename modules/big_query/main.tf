resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  description                 = var.dataset_description
  location                    = var.dataset_location
  default_table_expiration_ms = var.dataset_table_expiration

  labels = {
    project = var.project_id
  }

  # Provide Read and Write access to the rw service account #
  access {
    role          = "READER"
    user_by_email = google_service_account.bq_rw.email
  }

  access {
    role          = "WRITER"
    user_by_email = google_service_account.bq_rw.email
  }

  # Provide Read access to the ro service account #
  access {
    role          = "READER"
    user_by_email = google_service_account.bq_ro.email
  }

  # As Terraform creates the dataset - I found I had to ensure this persisted in the state #
  access {
    role          = "OWNER"
    user_by_email = "terraform@${var.project_id}.iam.gserviceaccount.com"
  }
}

# Read/Write service account for Big Query Dataset
resource "google_service_account" "bq_rw" {
  account_id   = "${var.service_account_id}-rw"
  display_name = "${var.service_account_name}-rw"
  project      = var.project_id
  description  = "${var.service_account_description} rw"
}

# Read Only service account for Big Query Dataset
resource "google_service_account" "bq_ro" {
  account_id   = "${var.service_account_id}-ro"
  display_name = "${var.service_account_name}-ro"
  project      = var.project_id
  description  = "${var.service_account_description} ro"
}