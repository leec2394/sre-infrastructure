variable project_id {
  description = "The ID of the project"
}

variable region {
  description = "The region in which the resource resides"
}

variable cluster_name {
  description = "The VPC in which the subnet resides in"
}

variable cluster_description {
  description = "The subnet CIDR"
}

variable vpc_id {
  description = "The name for the subnet"
}

variable subnet_id {
  description = "The name for the subnet"
}

variable cluster_node_pool_name {
  description = "The name for the subnet"
}

variable node_size {
  description = "The name for the subnet"
}

variable secondary_subnet_range {
  description = "The secondary subnet range to use for the cluster and pods"
}

variable service_account {
  description = "The service account to associate with the nodes"
}