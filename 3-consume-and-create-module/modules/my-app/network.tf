resource "google_compute_network" "vpc_network" {
  name                    = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "my-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "my-secondary-range"
    ip_cidr_range = "192.168.10.0/24"
  }
  depends_on = [
    resource.google_compute_network.vpc_network
  ]
}
