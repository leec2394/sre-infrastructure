# sre-infra

This repository contains the Terraform source code to build the following:

* A dedicated VPC to contain the resources
* Two subnets
    * App tier - private (for the GKE cluster)
    * Data tier - private (for the DB instance)
* A Cloud SQL instance - this will be provisioned with an empty DB and a firewall to restrict access
* A Big Query Dataset - this will be provisioned empty, with two user accounts
    * A read only account
    * A read/write account
* IAM Service account which provides access to Cloud SQL and BigQuery from GKE
* A GKE cluster

**Prerequisites**

This code assumes the following has already been configured:

* An existing GCP account
* A service account to allow Terraform access to create resources
* Terraform CLI 
* GCP credentials provided to the Terraform CLI

The only root variables you will need to provide are:

* project_id
* region

**Note - you may wish to change subnet CIDRs among other configurations set in main.tf**

This will simply create the infrastructure described above, you will then need to configure your workload via GKE and deploy your chosen application - you can then configure automated deployments. 

**Deployments to GKE**

Deployments to the GKE cluster are handled via continous delivery pipelines for GKE (this is a manual configuration - doesn't seem to be supported by Terraform) - changes pushed to the master branch of the application repository will trigger deployments - https://github.com/leec2394/sre-hello-world-app

The pipeline has been configured with details such as the Dockerfile location and Kubernetes YAML file location. A YAML file for Kubernetes configuration has been provided within the application repository (I have simply used the Google recommended YAML)

![Alt text](sre-hello-world-app.jpeg?raw=true "Architecture")