output "subnet_id" {
  value       = "${google_compute_subnetwork.subnet.id}"
  description = "an identifier for the resource"
}

output "subnet_creation_timestamp" {
  value       = "${google_compute_subnetwork.subnet.creation_timestamp}"
  description = "Creation timestamp in RFC3339 text format"
}

output "subnet_gateway_address" {
  value       = "${google_compute_subnetwork.subnet.gateway_address}"
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork"
}

output "subnet_self_link" {
  value       = "${google_compute_subnetwork.subnet.self_link}"
  description = "The URI of the created resource"
}