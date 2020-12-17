output "vpc_id" {
  value       = "${google_compute_network.vpc_network.id}"
  description = "an identifier for the resource"
}

output "gateway_ipv4" {
  value       = "${google_compute_network.vpc_network.gateway_ipv4}"
  description = "The gateway address for default routing out of the network. This value is selected by GCP"
}

output "self_link" {
  value       = "${google_compute_network.vpc_network.self_link}"
  description = "The URI of the created resource"
}