module "nginx_deployment" {
  source = "./modules/kube"

  namespace_name   = "testing"
  deployment_name  = "nginx"
  image            = "nginx:latest"
  region           = var.region
  k8s_cluster_name = var.k8s_cluster_name
}
