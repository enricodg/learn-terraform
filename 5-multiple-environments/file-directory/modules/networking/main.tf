resource "google_compute_network" "vpc_network" {
  name                    = "network-${var.environment}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "subnetwork-${var.environment}"
  ip_cidr_range = var.ip_range
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "secondary-range-${var.environment}"
    ip_cidr_range = var.secondary_ip_range
  }
  depends_on = [
    resource.google_compute_network.vpc_network
  ]
}