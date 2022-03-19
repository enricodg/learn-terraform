terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}

module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "10.0.0"

  name                = var.database_instance_name
  project_id          = var.project_id
  region              = var.region
  zone                = var.zone
  database_version    = "POSTGRES_11"
  user_name           = var.database_user
  db_name             = var.database_name
  deletion_protection = false
}
