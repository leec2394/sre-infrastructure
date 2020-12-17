output "service_account_id_rw" {
  value       = "${google_service_account.bq_rw.id}"
  description = "an identifier for the resource"
}

output "service_account_id_ro" {
  value       = "${google_service_account.bq_ro.id}"
  description = "an identifier for the resource"
}

output "service_account_name_rw" {
  value       = "${google_service_account.bq_rw.name}"
  description = "The fully-qualified name of the service account"
}

output "service_account_name_ro" {
  value       = "${google_service_account.bq_ro.name}"
  description = "The fully-qualified name of the service account"
}

output "service_account_unique_id_rw" {
  value       = "${google_service_account.bq_rw.unique_id}"
  description = "The unique id of the service account"
}

output "service_account_unique_id_ro" {
  value       = "${google_service_account.bq_ro.unique_id}"
  description = "The unique id of the service account"
}


output "big_query_dataset_id" {
  value       = "${google_bigquery_dataset.dataset.id}"
  description = "an identifier for the resource"
}

output "big_query_dataset_creation_time" {
  value       = "${google_bigquery_dataset.dataset.creation_time}"
  description = "A hash of the resource"
}

output "big_query_dataset_etag" {
  value       = "${google_bigquery_dataset.dataset.etag}"
  description = "The time when this dataset was created, in milliseconds since the epoch"
}

output "big_query_dataset_last_modified_time" {
  value       = "${google_bigquery_dataset.dataset.last_modified_time}"
  description = "The date when this dataset or any of its tables was last modified, in milliseconds since the epoch"
}

output "big_query_dataset_self_link" {
  value       = "${google_bigquery_dataset.dataset.self_link}"
  description = "The URI of the created resource"
}