resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.vpc_network.self_link
  region = var.region
}