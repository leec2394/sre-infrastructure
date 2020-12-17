output "db_self_link" {
  value       = "${google_sql_database_instance.db.self_link}"
  description = "The URI of the created resource"
}

output "db_connection_name" {
  value       = "${google_sql_database_instance.db.connection_name}"
  description = "The connection name of the instance to be used in connection strings"
}

output "db_private_ip_address" {
  value       = "${google_sql_database_instance.db.private_ip_address}"
  description = "The first private (PRIVATE) IPv4 address assigned"
}

output "db_initial_db_id" {
  value       = "${google_sql_database.default_db.id}"
  description = "an identifier for the resource"
}

output "db_initial_db_self_link" {
  value       = "${google_sql_database.default_db.self_link}"
  description = "The URI of the created resource"
}