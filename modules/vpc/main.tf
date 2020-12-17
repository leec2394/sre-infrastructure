resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_id}-vpc"
  description             = "A VPC to contain resources for the ${var.project_id} project"
  auto_create_subnetworks = false # I have defined my own subnets #
  project                 = var.project_id
}