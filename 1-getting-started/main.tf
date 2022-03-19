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
  region  = "asia-southeast2"
  zone    = "asia-southeast2-a"
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-southeast2"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "my-secondary-range"
    ip_cidr_range = "192.168.10.0/24"
  }
  depends_on = [
    resource.google_compute_network.vpc_network
  ]
}

resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
    }
  }
}
