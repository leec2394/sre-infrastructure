resource "google_container_cluster" "primary" {
  name        = var.cluster_name
  description = var.cluster_description
  project     = var.project_id
  location    = var.region
  network     = var.vpc_id
  subnetwork  = var.subnet_id

  # create the smallest possible default node pool and immediately delete it #
  remove_default_node_pool = true
  initial_node_count       = 1

  # Ensures basic auth is disabled #
  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  # Ensure our cluster and pods use the subnets we have provided #
  ip_allocation_policy {
    cluster_secondary_range_name  = var.secondary_subnet_range
    services_secondary_range_name = var.secondary_subnet_range
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.cluster_node_pool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  # Preemptible VMs #
  node_config {
    preemptible  = true
    machine_type = var.node_size

    # We want the nodes to use our custom service account with access to Big Query and SQL #
    service_account = var.service_account

    # When the legacy instance metadata APIs are disabled, requests to /0.1/ and /v1beta1/ metadata server endpoints will return 403 Forbidden #
    metadata = {
      disable-legacy-endpoints = "true"
    }

    # We use tags to associated the nodes with our firewall resource for the db #
    tags = ["gke"]

    # Scopes that are used by NAP when creating node pools #
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}