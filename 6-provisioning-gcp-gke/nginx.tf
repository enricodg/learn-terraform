# data "google_compute_network" "network" {
#   name = var.network_name
# }

# data "google_compute_subnetwork" "subnetwork" {
#   name = var.subnets[0].subnet_name
# }

module "nginx_deployment" {
  source = "./modules/kube"

  namespace_name   = "testing"
  deployment_name  = "nginx"
  image            = "nginx:latest"
  region           = var.region
  k8s_cluster_name = var.k8s_cluster_name
#   network          = network.name
#   subnetwork       = subnetwork.name
}
