resource "kubernetes_service" "service" {
  metadata {
    name      = var.deployment_name
    namespace = var.namespace_name
  }

  spec {
    selector = {
      app = kubernetes_deployment.deployment.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
