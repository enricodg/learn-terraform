terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}

locals {
  db_instance_spec = "db-f1-micro"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = data.google_compute_network.existing_default_network.id

  secondary_ip_range {
    range_name    = "my-secondary-range"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_sql_database_instance" "db_postgresql_1" {
  name                = "postgresql-instance"
  database_version    = "POSTGRES_11"
  region              = var.region
  deletion_protection = false

  settings {
    tier = local.db_instance_spec
  }
}

resource "google_sql_user" "db_postgresql_1_user" {
  name     = var.postgresql_username
  instance = google_sql_database_instance.db_postgresql_1.name
  password = var.postgresql_password
}

resource "google_sql_database" "test_db" {
  name     = "test_db"
  instance = google_sql_database_instance.db_postgresql_1.name
}
