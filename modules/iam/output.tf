output "service_account_id" {
  value       = "${google_service_account.service_account.id}"
  description = "an identifier for the resource"
}

output "service_account_name" {
  value       = "${google_service_account.service_account.name}"
  description = "The fully-qualified name of the service account"
}

output "service_account_unique_id" {
  value       = "${google_service_account.service_account.unique_id}"
  description = "The unique id of the service account"
}