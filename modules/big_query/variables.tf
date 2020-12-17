variable project_id {
  description = "The ID of the project"
}

variable dataset_id {
  description = "an identifier for the resource"
}

variable dataset_description {
  description = "A user-friendly description of the dataset"
}

variable dataset_location {
  description = "The geographic location where the dataset should reside"
}

variable dataset_table_expiration {
  description = "The default partition expiration for all partitioned tables in the dataset, in milliseconds"
}

variable service_account_id {
  description = "an identifier for the resource"
}

variable service_account_name {
  description = "The fully-qualified name of the service account"
}

variable service_account_description {
  description = "A description for the service account"
}