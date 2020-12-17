resource "google_sql_database_instance" "db" {
  name             = "${var.project_id}-cloud-sql-instance"
  database_version = var.db_version
  region           = var.region

  depends_on = [google_service_networking_connection.private_vpc_connection]

  project = var.project_id
  settings {
    tier              = var.db_tier
    availability_type = var.db_availability
    disk_size         = var.db_disk_size
    disk_type         = var.db_disk_type
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
    backup_configuration {
      binary_log_enabled = true
      enabled            = true
      start_time         = var.backup_time
    }
    user_labels = {
      identifier = "db"
    }
  }
}

# Private IP address range #
resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.project_id}-cloud-sql-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

# Created a private vpc connection with the range created above #
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Create a default empty database for our instance #
resource "google_sql_database" "default_db" {
  depends_on = [google_sql_database_instance.db]

  name     = var.db_name
  project  = var.project_id
  instance = google_sql_database_instance.db.name
}

# Create a firewall to restrict access to the db - inbound from gke #
resource "google_compute_firewall" "db_restricted_allow_inbound" {
  name = "${var.project_id}-db-restricted-allow-ingress"

  project = var.project_id
  network = var.vpc_id

  direction = "INGRESS"
  # We want to allow access from the GKE cluster - we can reference the secondary range and tags associated with the cluster/pods #
  source_ranges = var.source_ranges
  source_tags   = ["gke"]

  priority = "1000"

  allow {
    protocol = "tcp"
    ports    = ["1433"]
  }
}