terraform {
  backend "gcs" {
    bucket  = "tf-state-testing-123123"
    prefix  = "terraform/state"
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.14.0"
    }
  }
}

provider "google" {
  project = "enrico-labs"
  region  = "asia-southeast2"
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network-1"
  auto_create_subnetworks = true
}
