################
### Provider ###
################
provider "google" {
  project = var.project_id
  region  = var.region
}

###########
### VPC ###
###########
module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
}

#############################
### Subnets - Application ###
#############################
module "private_subnet_app" {
  source                = "./modules/networking"
  project_id            = var.project_id
  subnet_cidr           = "10.24.1.0/24"
  region                = "${var.region}"
  vpc_id                = module.vpc.vpc_id
  subnet_name           = "${var.project_id}-${var.region}-app"
  subnet_cidr_secondary = "10.25.0.0/19"
}

######################
### Subnets - Data ###
######################
module "private_subnet_data" {
  source                = "./modules/networking"
  project_id            = var.project_id
  subnet_cidr           = "10.28.1.0/24"
  region                = "${var.region}"
  vpc_id                = module.vpc.vpc_id
  subnet_name           = "${var.project_id}-${var.region}-data"
  subnet_cidr_secondary = "10.29.0.0/19"
}

##############################
### IAM - Service Accounts ###
##############################
module "iam" {
  source                      = "./modules/iam"
  project_id                  = var.project_id
  service_account_id          = "${var.project_id}-gke-service-account"
  service_account_name        = "${var.project_id}-gke-service-account"
  service_account_description = "A service account that provides access to Cloud SQL and BigQuery from GKE"
  role_name                   = "sre_role_custom_gke_role"
  role_description            = "A custom role that provides access to Cloud SQL and BigQuery"
}

#################
### Big Query ###
#################
module "big_query" {
  source                      = "./modules/big_query"
  project_id                  = var.project_id
  dataset_id                  = "sre_role_bq_dataset"
  dataset_description         = "A Big Query Dataset for the ${var.project_id} project"
  dataset_location            = "EU"
  dataset_table_expiration    = 3600000
  service_account_id          = "${var.project_id}-bq-service-account"
  service_account_name        = "${var.project_id}-bq-service-account"
  service_account_description = "A service account that provides access to the Big Query Dataset"
}

#################
### Cloud SQL ###
#################
module "cloud_sql" {
  source          = "./modules/cloud_sql"
  project_id      = var.project_id
  region          = var.region
  db_version      = "MYSQL_5_6"
  db_tier         = "db-f1-micro"
  db_availability = "REGIONAL"
  db_disk_size    = 10
  db_disk_type    = "PD_SSD"
  db_name         = "${var.project_id}-initial-db"
  vpc_id          = module.vpc.vpc_id
  backup_time     = "00:00"
  source_ranges   = ["10.25.0.0/19"] # Restrict access to the DB - access from the GKE cluster only #
}

###################
### GKE Cluster ###
###################
module "gke_cluster" {
  source                 = "./modules/gke"
  project_id             = var.project_id
  region                 = var.region
  vpc_id                 = module.vpc.vpc_id
  cluster_name           = "${var.project_id}-gke-cluster"
  cluster_description    = "A GKE Cluster for the ${var.project_id} project"
  subnet_id              = module.private_subnet_app.subnet_id
  cluster_node_pool_name = "${var.project_id}-gke-cluster-node"
  node_size              = "e2-micro"
  secondary_subnet_range = "sre-role-europe-west2-app-secondary"
  service_account        = module.iam.service_account_unique_id
}