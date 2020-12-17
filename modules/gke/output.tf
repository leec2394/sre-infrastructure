output "cluster_id" {
  value       = "${google_container_cluster.primary.id}"
  description = "an identifier for the resource"
}

output "cluster_self_link" {
  value       = "${google_container_cluster.primary.self_link}"
  description = "The server-defined URL for the resource"
}

output "cluster_endpoint" {
  value       = "${google_container_cluster.primary.endpoint}"
  description = "The IP address of this cluster's Kubernetes master"
}

output "cluster_master_version" {
  value       = "${google_container_cluster.primary.master_version}"
  description = "The current version of the master in the cluster. This may be different than the min_master_version set in the config if the master has been updated by GKE"
}