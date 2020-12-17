variable project_id {
  description = "The ID of the project"
}

variable region {
  description = "The region in which the resource resides"
}

variable db_version {
  description = "The tier in which the subnet belongs to (eg. web/app/data)"
}

variable db_tier {
  description = "The VPC in which the subnet resides in"
}

variable db_availability {
  description = "The subnet CIDR"
}

variable db_disk_size {
  description = "The subnet CIDR"
}

variable db_disk_type {
  description = "The subnet CIDR"
}

variable db_name {
  description = "The default db name"
}

variable vpc_id {
  description = "The VPC in which the subnet resides in"
}

variable backup_time {
  description = "The backup time for the SQL instance"
}

variable source_ranges {
  description = "The subnet ranges allowed ingress access to the db"
}