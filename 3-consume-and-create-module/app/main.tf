terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "my_app_1" {
  source = "../modules/my-app"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  labels     = var.labels
}

module "my_db_1" {
  source = "../modules/google-cloud-sql"

  database_user          = var.database_user
  database_instance_name = var.database_instance_name
  region                 = var.region
  zone                   = var.zone
  project_id             = var.project_id
}
