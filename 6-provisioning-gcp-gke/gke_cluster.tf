module "kubernetes_engine" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "20.0.0"

  project_id = var.project_id
  name       = var.k8s_cluster_name
  region     = var.region
  zones      = var.zone_list
  network    = var.network_name
  subnetwork = var.subnets[0].subnet_name

  ip_range_pods     = var.subnet_secondary_ranges["subnet-01"][0].range_name
  ip_range_services = var.subnet_secondary_ranges["subnet-01"][1].range_name

  add_cluster_firewall_rules = true
  create_service_account     = true
  remove_default_node_pool   = true
  initial_node_count         = 1

  depends_on = [
    module.network
  ]
}
