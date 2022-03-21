module "network" {
  source  = "terraform-google-modules/network/google"
  version = "5.0.0"

  project_id   = var.project_id
  network_name = var.network_name
  routing_mode = var.routing_mode

  subnets = var.subnets

  secondary_ranges = var.subnet_secondary_ranges

  routes = var.network_routes
}
