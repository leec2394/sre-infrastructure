resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = var.vpc_id

  # We need a secondary IP range to assign to our GKE cluster and nodes #
  secondary_ip_range {
    range_name    = "${var.subnet_name}-secondary"
    ip_cidr_range = var.subnet_cidr_secondary
  }
}