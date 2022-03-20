terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}

provider "google" {
  project = "enrico-labs"
  region  = var.region
}

module "network" {
    source = "../modules/networking"

    environment = var.environment
    region = var.region
    ip_range = var.ip_range
    secondary_ip_range = var.secondary_ip_range
}